#include <math.h>
#include <stdio.h>
#include <string.h>
#include <net/if.h>
#include <net/if_mib.h>
#include <sys/select.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

static char unit_str[3][6] = { { " Bps" }, { "KBps" }, { "MBps" }, };

enum unit {
  UNIT_BPS,
  UNIT_KBPS,
  UNIT_MBPS
};
struct network {
  uint32_t row;
  char* ifname;
  struct ifmibdata data;
  struct timeval tv_nm1, tv_n, tv_delta;

  int up;
  int down;
  enum unit up_unit, down_unit;

  char name[64];
  struct in_addr ip;
};

static inline void ifdata(uint32_t net_row, struct ifmibdata* data) {
	static size_t size = sizeof(struct ifmibdata);
  static int32_t data_option[] = { CTL_NET, PF_LINK, NETLINK_GENERIC, IFMIB_IFDATA, 0, IFDATA_GENERAL };
  data_option[4] = net_row;
  sysctl(data_option, 6, data, &size, NULL, 0);
}

static inline void network_init(struct network* net, char* ifname) {
  memset(net, 0, sizeof(struct network));

  // Store name
  net->ifname = ifname;

  static int count_option[] = { CTL_NET, PF_LINK, NETLINK_GENERIC, IFMIB_SYSTEM, IFMIB_IFCOUNT };
  uint32_t interface_count = 0;
  size_t size = sizeof(uint32_t);
  sysctl(count_option, 5, &interface_count, &size, NULL, 0);

  for (int i = 0; i < interface_count; i++) {
    ifdata(i, &net->data);
    if (strcmp(net->data.ifmd_name, ifname) == 0) {
      net->row = i;
      break;
    }
  }
}

static inline void network_update(struct network* net) {
  gettimeofday(&net->tv_n, NULL);
  timersub(&net->tv_n, &net->tv_nm1, &net->tv_delta);
  net->tv_nm1 = net->tv_n;

  uint64_t ibytes_nm1 = net->data.ifmd_data.ifi_ibytes;
  uint64_t obytes_nm1 = net->data.ifmd_data.ifi_obytes;
  ifdata(net->row, &net->data);

  double time_scale = (net->tv_delta.tv_sec + 1e-6*net->tv_delta.tv_usec);
  if (time_scale < 1e-6 || time_scale > 1e2) return;
  double delta_ibytes = (double)(net->data.ifmd_data.ifi_ibytes - ibytes_nm1)
                        / time_scale;
  double delta_obytes = (double)(net->data.ifmd_data.ifi_obytes - obytes_nm1)
                        / time_scale;

  double exponent_ibytes = log10(delta_ibytes);
  double exponent_obytes = log10(delta_obytes);

  if (exponent_ibytes < 3) {
    net->down_unit = UNIT_BPS;
    net->down = delta_ibytes;
  } else if (exponent_ibytes < 6) {
    net->down_unit = UNIT_KBPS;
    net->down = delta_ibytes / 1000.0;
  } else if (exponent_ibytes < 9) {
    net->down_unit = UNIT_MBPS;
    net->down = delta_ibytes / 1000000.0;
  }

  if (exponent_obytes < 3) {
    net->up_unit = UNIT_BPS;
    net->up = delta_obytes;
  } else if (exponent_obytes < 6) {
    net->up_unit = UNIT_KBPS;
    net->up = delta_obytes / 1000.0;
  } else if (exponent_obytes < 9) {
    net->up_unit = UNIT_MBPS;
    net->up = delta_obytes / 1000000.0;
  }

  // Retrieve and store the network name and IP address
  struct ifaddrs *ifaddr, *ifa;
  if (getifaddrs(&ifaddr) == -1) {
    perror("getifaddrs");
    return;
  }

  for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
    if (ifa->ifa_addr == NULL)
      continue;

    // Check for the specified interface name
    if (strcmp(ifa->ifa_name, net->ifname) == 0) {
      printf("Found network interface: %s\n", net->name);

      // Store the IP address
      struct sockaddr_in *addr = (struct sockaddr_in *)ifa->ifa_addr;
      net->ip = addr->sin_addr;
      break;
    }
  }

  freeifaddrs(ifaddr);

  // Check if the network is WiFi or Ethernet and retrieve the SSID if WiFi
  char connection_type[64];
  FILE *fp = popen("/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'", "r");
  if (fp == NULL) {
    strcpy(net->name, "unknown");
  } else {
    if (fgets(net->name, IFNAMSIZ, fp) != NULL) {
      // Remove newline character from SSID if it exists
      size_t len = strlen(net->name);
      if (len > 0 && net->name[len - 1] == '\n') {
        net->name[len - 1] = '\0';
      }
    } else {
      // If no SSID is returned, assume it's a wired connection
      strcpy(net->name, "wired");
    }
    pclose(fp);
  }

  // Print the network name and IP address
  char ip_str[INET_ADDRSTRLEN];
  inet_ntop(AF_INET, &(net->ip), ip_str, INET_ADDRSTRLEN);
  printf("Network interface: %s, IP address: %s\n", net->name, ip_str);
}
