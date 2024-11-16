from mitmproxy import http


def request(flow: http.HTTPFlow) -> None:
    # Disallow telemetry to go through
    if "telemetry" in flow.request.pretty_host:
        flow.response = http.Response.make(418, b"no telemetry for you")

    # If the "nwo" JSON field in the request was "cbrxyz/vault" then return 418
    if "nwo" in flow.request.text and "cbrxyz/vault" in flow.request.text:
            flow.response = http.Response.make(418, b"no vault for you")
