# ~/.bash_aliases - Bash aliases for WSL/Ubuntu
# Source: https://github.com/YOUR_USERNAME/win-dotfiles

# ===== Navigation =====
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# Quick directories
alias dev="cd ~/dev"
alias repos="cd ~/repos"
alias dl="cd ~/Downloads"
alias docs="cd ~/Documents"
alias dotfiles="cd \$DOTFILES"

# ===== Directory Listing =====
# Use exa/eza if available, fallback to ls
if command -v eza &> /dev/null; then
    alias ls="eza --icons"
    alias ll="eza --icons -la"
    alias la="eza --icons -a"
    alias l="eza --icons -a"
    alias lt="eza --icons --tree --level=2"
    alias llt="eza --icons -la --tree --level=2"
elif command -v exa &> /dev/null; then
    alias ls="exa --icons"
    alias ll="exa --icons -la"
    alias la="exa --icons -a"
    alias l="exa --icons -a"
    alias lt="exa --icons --tree --level=2"
else
    alias ls="ls --color=auto"
    alias ll="ls -lah"
    alias la="ls -A"
    alias l="ls -CF"
fi

# ===== Modern CLI Tools =====
command -v bat &> /dev/null && alias cat="bat"
command -v batcat &> /dev/null && alias cat="batcat"  # Ubuntu names it batcat
command -v rg &> /dev/null && alias grep="rg"
command -v fd &> /dev/null && alias find="fd"
command -v fdfind &> /dev/null && alias find="fdfind"  # Ubuntu names it fdfind

# ===== Git =====
alias g="git"
alias gst="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline -15"
alias glog="git log --graph --oneline --decorate --all"
alias gf="git fetch"
alias gfa="git fetch --all --prune"
alias gstash="git stash"
alias gpop="git stash pop"

# ===== Docker =====
alias d="docker"
alias dc="docker compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dimg="docker images"
alias dprune="docker system prune -af"

# ===== System =====
alias reload="source ~/.bashrc && echo 'Bashrc reloaded'"
alias path='echo $PATH | tr ":" "\n"'
alias envs="env | sort"
alias ports="netstat -tulanp 2>/dev/null || ss -tulanp"
alias myip="curl -s ifconfig.me"
alias localip="hostname -I | awk '{print \$1}'"

# ===== APT (Ubuntu) =====
alias update="sudo apt update && sudo apt upgrade -y"
alias install="sudo apt install -y"
alias search="apt search"
alias remove="sudo apt remove"
alias cleanup="sudo apt autoremove -y && sudo apt autoclean"

# ===== Files =====
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"
alias df="df -h"
alias du="du -h"
alias free="free -h"

# ===== Misc =====
alias c="clear"
alias h="history"
alias now="date '+%Y-%m-%d %H:%M:%S'"
alias week="date +%V"
alias weather="curl -s 'wttr.in/?format=3'"

# ===== Windows Integration (WSL) =====
alias explorer="explorer.exe"
alias code="code"
alias winhome="cd \$WINHOME"
alias windesktop="cd \$WINHOME/Desktop"
alias windownloads="cd \$WINHOME/Downloads"

# ===== Functions =====
# Create directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Show directory sizes sorted
duh() {
    du -h --max-depth=1 "${1:-.}" 2>/dev/null | sort -hr
}

# Quick HTTP server
serve() {
    python3 -m http.server "${1:-8000}"
}

# Find process by name
psg() {
    ps aux | grep -v grep | grep -i "$1"
}

# Kill process by name
pkill() {
    ps aux | grep -v grep | grep -i "$1" | awk '{print $2}' | xargs kill -9
}
