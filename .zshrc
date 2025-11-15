#! /bin/zsh
###############################################################################
# oh-my-zsh setup
###############################################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# shellcheck disable=SC2296 # zsh-specific ${(b)...} expansion
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh setup
export plugins=(git z zsh-vi-mode brew zsh-autosuggestions zsh-syntax-highlighting)
export ZSH="/Users/$COMP_USER/.oh-my-zsh"
export CASE_SENSITIVE="false"
export HYPHEN_INSENSITIVE="true"
export DISABLE_AUTO_UPDATE="false"
export DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=30
export DISABLE_MAGIC_FUNCTIONS="false"
export DISABLE_LS_COLORS="false"
export DISABLE_AUTO_TITLE="false"
export ENABLE_CORRECTION="true"
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
export COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
export DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
export HIST_STAMPS="mm/dd/yyyy"

# Local computer configuration
source ~/.config/local-comp.zsh

# zsh-vi-mode setup
function zvm_config() {
	export ZVM_VI_ESCAPE_BINDKEY=jk
}

export ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

source "$ZSH/oh-my-zsh.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':completion:*' menu select
###############################################################################

###############################################################################
# PATH expansions
###############################################################################
export PATH=/opt/homebrew/bin:$PATH
export PATH=/Users/cameronbrown/mnt/catkin_ws/devel/lib/python2.7/dist-packages:$PATH
export PATH=/Users/cameronbrown/.cargo/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cameronbrown/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cameronbrown/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cameronbrown/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cameronbrown/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Fix Go issues
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"
export FLYCTL_INSTALL="/Users/cameronbrown/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/jre/bin:$PATH
export PATH=/opt/homebrew/Cellar/qt@5/5.15.7/bin:$PATH
export PATH="/opt/homebrew/opt/poppler-qt5/bin:$PATH"

# Following line was automatically added by arttime installer
export PATH=/Users/cameronbrown/.local/bin:$PATH

export PATH=$PATH:/Users/cameronbrown/.spicetify

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql/bin:$PATH"

eval "$(luarocks path)"
# add current dirs
export LUA_PATH="${LUA_PATH};./?.lua;./?/init.lua"
###############################################################################

###############################################################################
# Utility source files
###############################################################################
# This enables the Homebrew command not found
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi
###############################################################################

###############################################################################
# Utility variables
###############################################################################
export EDITOR="nvim"
export GREP_OPTIONS='--color=always'
export FZF_DEFAULT_COMMAND="rg --files -g '!*.o'"

# Parallels ssh config
export SSH="cameron@10.211.55.6"
export SCP="scp://$SSH"

export PYTHONPATH="/Users/cameronbrown/Library/Mobile Documents/com~apple~CloudDocs/Coding/beeminder.py:$PYTHONPATH"
export PYTHONPATH="/Users/cameronbrown/cop-gradescope-api:$PYTHONPATH"

export LDFLAGS="-L/opt/homebrew/opt/poppler-qt5/lib"
export CPPFLAGS="-I/opt/homebrew/opt/poppler-qt5/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/poppler-qt5/lib/pkgconfig"
export PKG_CONFIG_PATH="/opt/homebrew/opt/poppler-qt5/share/pkgconfig"
###############################################################################

###############################################################################
# Utility aliases
###############################################################################
# COMMANDS
alias head="ghead" # GNU head supports negative numbers
alias lsd="lsd -al"
alias pinentry='pinentry-mac'
alias p='python3'
alias python="python3"
alias spt="spotify_player"
alias tree="tree -C"
alias recent="ls -tal | head -n 10"
alias restart="source ~/.zshrc"
alias yt-dlp="yt-dlp --config-location ~/.config/yt-dlp/config/always.conf"
alias vault="cd /Users/cameronbrown/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault"
alias wvim="nvim -c ':Light'"
alias things="taskwarrior-tui"

# INTERNET
alias gnv="curl -s -N v2d.wttr.in/Gainesville  | ghead -n -2"
alias boc="curl -s -N 'v2d.wttr.in/Boca+Raton' | ghead -n -2"
alias pit="curl -s -N 'v2d.wttr.in/Pittsburgh' | ghead -n -2"
alias lofi="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=jfKfPfyJRdk"
alias synth="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=4xDzrJKXOOY"
alias classical="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=sGHgBP9-zXo"
alias jazz="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=Dx5qFachd3A --demuxer-readahead-secs=60"
alias h3vids="youtube-dl --get-filename -o '%(upload_date)s, %(title)s, https://www.youtube.com/watch?v=%(id)s' 'https://www.youtube.com/@H3Podcast/streams'"

# MOVING
alias icloud='cd /Users/$COMP_USER/Library/Mobile\ Documents/com~apple~CloudDocs'

# POWER
alias dsn='pmset displaysleepnow'
alias lungo="open -g 'lungo:activate?hours=1'"

# DEVICES
alias airpods="blueutil --connect b8-81-fa-ce-c2-31 && SwitchAudioSource -s 'cam airpods'"
alias hp="blueutil --connect 14-3f-a6-3d-6b-f3 & SwitchAudioSource -s 'WH-1000XM4'"

# PROGRAMS
alias dup='open . -a iterm'

# UF
alias libcap="python3 ~/scripting/libcap.py"
alias laundry="python3 ~/scripting/laundry.py"
alias f21='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/fall2021 && n'
alias s22='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/spring2022 && n'
alias u22='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/summer2022 && n'
alias f22='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/fall2022 && n'
alias s23='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/spring2023 && n'
alias f23='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/fall2023 && n'
alias s24='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/spring2024 && n'
alias f24='cd /Users/cameronbrown/Library/Mobile\ Documents/com~apple~CloudDocs/College/fall2024 && n'
###############################################################################

###############################################################################
# Utility functions
###############################################################################
function color() {
        if [ "$1" = "red" ]; then
                echo -e "\033]6;1;bg;red;brightness;248\a"
                echo -e "\033]6;1;bg;green;brightness;102\a"
                echo -e "\033]6;1;bg;blue;brightness;110\a"
        elif [ "$1" = "orange" ]; then
                echo -e "\033]6;1;bg;red;brightness;246\a"
                echo -e "\033]6;1;bg;green;brightness;169\a"
                echo -e "\033]6;1;bg;blue;brightness;87\a"
        elif [ "$1" = "yellow" ]; then
                echo -e "\033]6;1;bg;red;brightness;250\a"
                echo -e "\033]6;1;bg;green;brightness;221\a"
                echo -e "\033]6;1;bg;blue;brightness;43\a"
        elif [ "$1" = "green" ]; then
                echo -e "\033]6;1;bg;red;brightness;174\a"
                echo -e "\033]6;1;bg;green;brightness;231\a"
                echo -e "\033]6;1;bg;blue;brightness;110\a"
        elif [ "$1" = "blue" ]; then
                echo -e "\033]6;1;bg;red;brightness;101\a"
                echo -e "\033]6;1;bg;green;brightness;224\a"
                echo -e "\033]6;1;bg;blue;brightness;223\a"
        elif [ "$1" = "purple" ]; then
                echo -e "\033]6;1;bg;red;brightness;124\a"
                echo -e "\033]6;1;bg;green;brightness;91\a"
                echo -e "\033]6;1;bg;blue;brightness;209\a"
        else
                echo "Invalid color."
        fi
}

function mdc() {
	pandoc "$1" -o temp.html
	cat temp.html | clipboard
	cat temp.html | wc -l | awk '{print $1 " lines copied and ready for Canvas."}'
	rm temp.html
}

n()
{
    # Block nesting of nnn in subshells
    if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export EDITOR="nvm"

    nnn "$@"
    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

aerospace-cleanup() {
    ghost_window_ids=$(aerospace list-windows --all | grep -e '.|.| $' | awk '{print $1}')
    for id in $ghost_window_ids; do
    echo "Closing ghost window ID: $id"
    aerospace close --window-id "$id"
    done
}

# s alias to open today's daily note in my vault in nvim
s() {
    nvim /Users/cameronbrown/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/vault/dailies/"$(date +'%Y-%m-%d')".md
}

dmb() {
    git diff "$(git merge-base --fork-point "$(git branch -l main master --format '%(refname:short)')" HEAD)"
}

# clean spotlight config (macos)
clean_spotlight() {
    sudo mdutil -a -i off
    sudo rm -r /System/Volumes/Data/.Spotlight-V100
    sudo mdutil -a -i on
}

# get wifi pass
wifipass() {
    security find-generic-password -ga "$1" | grep "password:"
}

recycle() {
    sudo rm -rf ~/.Trash/*
}

prettycp() {
    rsync --recursive --times --modify-window=2 --progress --verbose --itemize-changes --stats --human-readable
}

valgrind() {
    docker run -ti -v "$PWD":/workdir memory-test:0.1 \
        bash -lc 'cd /workdir && g++ --std=c++20 -g "$@" && valgrind --error-exitcode=1 --leak-check=full ./a.out' -- "$@"
}

maples() {
    yt-dlp --embed-metadata --download-archive ~/.config/yt-dlp/miamaples.txt "$1"
}

class() {
    yt-dlp --embed-metadata --embed-subs --download-archive ~/.config/yt-dlp/class.txt "$1"
}

upload-key() {
    ssh-copy-id -i ~/.ssh/cameron-cbrxyz.pub "$1"
}

add-shadow() {
    convert "$1" -trim \( +clone -background grey25 -shadow 80x40+5+30 \) +swap -background transparent -layers merge +repage "$1-shadow.png"
}

# Accepts one history line number as argument.
# Use `dc -1` to remove the last line.
dc () {
  # Prevent the specified history line from being saved.
  # shellcheck disable=SC2296 # zsh-specific ${(b)...} expansion
  local HISTORY_IGNORE="${(b)$(fc -ln "$1" "$1")}"

  # Write out the history to file, excluding lines that
  # match `$HISTORY_IGNORE`.
  fc -W

  # Dispose of the current history and read the new
  # history from file.
  fc -p "$HISTFILE" $HISTSIZE "$SAVEHIST"

  # TA-DA!
  print "Deleted '$HISTORY_IGNORE' from history."
}

# potentially borrowed from forrest
autopush() {
	git push origin +"${1:-HEAD}":refs/heads/autopush-"$USER"-"$(uuidgen --random | cut -c1-8)"-citmp
}

# CPP

ccls() {
    exec /opt/homebrew/bin/ccls --init='{"clang":{"extraArgs":[
  "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/v1",
  "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.0.0/include",
  "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
  "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
  "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks",
  "-isystem/Users/cameronbrown/cpp/roscpp/include"
]}}' "$@"
}
bolt() {
    nvim "$(mktemp /tmp/demo-XXXXXXXXXXXXXXXXX.cpp)"
}
cppw() {
	g++ ./*.cpp --std=c++11
	./a.out
	rm a.out
}
# grr --> g++ compile with c++17 and warning to errors
# executable is named first instance of "X.cpp" --> "X" = "-o X"
grr() {
    if [ $# -lt 1 ]; then
        echo "Usage: grr file1.cpp [file2.cpp ...]"
        return 1
    fi
    for arg in "$@"; do
        if [[ $arg == *.cpp ]]; then
            exe_name="${arg%.cpp}"
        # if we have no custom exe name and this arg aint it
        elif [ -z "$exe_name" ]; then
            exe_name="a.out"
        fi
    done
    g++ -std=c++17 -Wall -Werror -Wextra "$@" -o "$exe_name"
}

# do grr AND run the executable instantly
gpp() {
    if [ $# -lt 1 ]; then
        echo "Usage: gpp file1.cpp [file2.cpp ...]"
        return 1
    fi
    # run grr
    if grr "$@"; then
        "./$exe_name"
    else
        echo "compilation failed."
        return 1
    fi
}
###############################################################################
source ~/.zsh/rosbash

# Completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi
