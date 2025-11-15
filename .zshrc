# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z vi-mode brew zsh-autosuggestions zsh-syntax-highlighting)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Local computer configuration
source ~/.config/local-comp.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/$COMP_USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

function zvm_config() {
	ZVM_VI_ESCAPE_BINDKEY=jk
}

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=/opt/homebrew/bin:$PATH
export PATH=/Users/cameronbrown/mnt/catkin_ws/devel/lib/python2.7/dist-packages:$PATH
export PATH=/Users/cameronbrown/.cargo/bin:$PATH

# Custom aliases
alias dsn='pmset displaysleepnow'
alias icloud='cd /Users/$COMP_USER/Library/Mobile\ Documents/com~apple~CloudDocs'
alias dup='open . -a iterm'
alias p='python3'
alias lsd="lsd -al"
alias lungo="open -g 'lungo:activate?hours=1'"

# Fix Go issues
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

zstyle ':completion:*' menu select

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

export GREP_OPTIONS='--color=always'

alias scripts="echo '
List of helpful aliases:

airpods
libcap
laundry
'"

# sound
alias airpods="blueutil --connect b8-81-fa-ce-c2-31 && SwitchAudioSource -s 'cam airpods'"
alias hp="blueutil --connect 14-3f-a6-3d-6b-f3 & SwitchAudioSource -s 'WH-1000XM4'"
alias bm="python3 ~/scripting/bm.py"

# uf utilities
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

function cppw() {
	g++ *.cpp --std=c++11
	./a.out
	rm a.out
}

function mdc() {
	pandoc $1 -o temp.html
	cat temp.html | clipboard
	cat temp.html | wc -l | awk '{print $1 " lines copied and ready for Canvas."}'
	rm temp.html
}

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
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

export EDITOR="nvim"

# Set PYTHONPATH
alias python="python3"

# Parallels ssh conifg
export SSH="cameron@10.211.55.6"
export SCP="scp://$SSH"

export FLYCTL_INSTALL="/Users/cameronbrown/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cameronbrown/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cameronbrown/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cameronbrown/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cameronbrown/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# This eanbles the Homebrew command not found
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

export FZF_DEFAULT_COMMAND="rg --files -g '!*.o'"

alias tree="tree -C"
alias recent="ls -tal | head -n 10"
alias restart="source ~/.zshrc"

alias wvim="nvim -c ':Light'"

alias things="taskwarrior-tui"

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

source ~/.zsh/rosbash
alias pinentry='pinentry-mac'
export PYTHONPATH="/Users/cameronbrown/Library/Mobile Documents/com~apple~CloudDocs/Coding/beeminder.py:$PYTHONPATH"
export PYTHONPATH="/Users/cameronbrown/cop-gradescope-api:$PYTHONPATH"
# alias mpv='mpv --input-media-keys=yes'

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/jre/bin:$PATH
export PATH=/opt/homebrew/Cellar/qt@5/5.15.7/bin:$PATH
export PATH="/opt/homebrew/opt/poppler-qt5/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/poppler-qt5/lib"
export CPPFLAGS="-I/opt/homebrew/opt/poppler-qt5/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/poppler-qt5/lib/pkgconfig"
export PKG_CONFIG_PATH="/opt/homebrew/opt/poppler-qt5/share/pkgconfig"
# alias head="ghead" # GNU head supports negative numbers

alias gnv="curl -s -N v2d.wttr.in/Gainesville | head -n -2"
alias boc="curl -s -N 'v2d.wttr.in/Boca+Raton' | head -n -2"
alias lofi="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=jfKfPfyJRdk"
alias synth="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=4xDzrJKXOOY"
alias classical="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=sGHgBP9-zXo"
alias jazz="mpv --no-video --no-resume-playback https://www.youtube.com/watch\?v\=Dx5qFachd3A --demuxer-readahead-secs=60"
alias h3vids="youtube-dl --get-filename -o '%(upload_date)s, %(title)s, https://www.youtube.com/watch?v=%(id)s' 'https://www.youtube.com/@H3Podcast/streams'"
add-shadow() {
    convert "$1" -trim \( +clone -background grey25 -shadow 80x40+5+30 \) +swap -background transparent -layers merge +repage "$1-shadow.png"
}

# Following line was automatically added by arttime installer
export PATH=/Users/cameronbrown/.local/bin:$PATH

# Completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

alias mtr="/opt/homebrew/Cellar/mtr/0.95/sbin/mtr"
valgrind() {
    docker run -ti -v $PWD:/workdir memory-test:0.1 bash -c "cd /workdir && g++ --std=c++20 -g "$@" && valgrind --error-exitcode=1 --leak-check=full ./a.out"
}
alias sp="bm sp 1 --comment \"Added via command-line at `date '+%I:%m %p'`.\""
drink() {
    shortcuts run "Log Drink" <<< "$1 $2"
}
alias water="drink water"
alias milk="drink milk"
alias soda="drink soda"
alias tkn="python3 ~/scripts/tkn.py"
alias unix="date -r"
alias sports_drink="drink \"Sports Drink\""
alias bottle="shortcuts run \"Log Bottle\""

maples() {
    yt-dlp --embed-metadata --download-archive ~/.config/yt-dlp/miamaples.txt $1
}

class() {
    yt-dlp --embed-metadata --embed-subs --download-archive ~/.config/yt-dlp/class.txt $1
}

alias yt-dlp="yt-dlp --config-location ~/.config/yt-dlp/config/always.conf"
alias dmb="git diff $(git merge-base --fork-point $(git branch -l main master --format '%(refname:short)') HEAD)"
alias vault="cd /Users/cameronbrown/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault"

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
    grr "$@"
    if [ $? -eq 0 ]; then
        ./$exe_name
    else
        echo "Compilation failed."
    fi
}

export PATH=$PATH:/Users/cameronbrown/.spicetify

upload-key() {
    ssh-copy-id -i ~/.ssh/cameron-cbrxyz.pub $1
}
eval $(luarocks path)
# add current dirs
export LUA_PATH="${LUA_PATH};./?.lua;./?/init.lua"

# s alias to open today's daily note in my vault in nvim
s() {
    nvim /Users/cameronbrown/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/vault/dailies/"$(date +'%Y-%m-%d')".md
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

# Accepts one history line number as argument.
# Use `dc -1` to remove the last line.
dc () {
  # Prevent the specified history line from being
  # saved.
  local HISTORY_IGNORE="${(b)$(fc -ln $1 $1)}"

  # Write out the history to file, excluding lines that
  # match `$HISTORY_IGNORE`.
  fc -W

  # Dispose of the current history and read the new
  # history from file.
  fc -p $HISTFILE $HISTSIZE $SAVEHIST

  # TA-DA!
  print "Deleted '$HISTORY_IGNORE' from history."
}

# potentially borrowed from forrest
autopush() {
	git push origin +"${1:-HEAD}":refs/heads/autopush-"$USER"-"$(uuidgen --random | cut -c1-8)"-citmp
}

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export MallocNanoZone=0

alias spt="spotify_player"
export PATH="/opt/homebrew/opt/mysql/bin:$PATH"

if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi

bolt() {
    nvim "$(mktemp /tmp/demo-XXXXXXXXXXXXXXXXX.cpp)"
}

aerospace-cleanup() {
    ghost_window_ids=$(aerospace list-windows --all | grep -e '.|.| $' | awk '{print $1}')
    for id in $ghost_window_ids; do
    echo "Closing ghost window ID: $id"
    aerospace close --window-id "$id"
    done
}
