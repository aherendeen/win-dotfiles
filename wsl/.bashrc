# ~/.bashrc - Bash configuration for WSL/Ubuntu
# Source: https://github.com/YOUR_USERNAME/win-dotfiles

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ===== History =====
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="ls:ll:cd:pwd:exit:clear:history"
shopt -s histappend

# ===== Shell Options =====
shopt -s checkwinsize   # Update LINES and COLUMNS after each command
shopt -s globstar       # ** matches all files and directories
shopt -s cdspell        # Autocorrect typos in cd
shopt -s autocd         # cd into directory by typing name
shopt -s dirspell       # Autocorrect directory names

# ===== Environment =====
export EDITOR="code --wait"
export VISUAL="code --wait"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Dotfiles location
export DOTFILES="$HOME/.dotfiles"

# Tool settings
export BAT_THEME="Dracula"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#bd93f9,fg:#f8f8f2,header:#6272a4,info:#ffb86c,pointer:#ff79c6,marker:#ff79c6,fg+:#f8f8f2,prompt:#50fa7b,hl+:#bd93f9"

# ===== Path =====
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ===== Aliases =====
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# ===== Completions =====
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# ===== FZF =====
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ===== Zoxide (better cd) =====
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# ===== Starship Prompt =====
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# ===== WSL-specific =====
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    # Windows home directory
    export WINHOME="/mnt/c/Users/${USER}"
    
    # Open files in Windows default app
    alias open="explorer.exe"
    alias xdg-open="explorer.exe"
    
    # Access Windows clipboard
    alias pbcopy="clip.exe"
    alias pbpaste="powershell.exe -command 'Get-Clipboard' | head -n -1"
fi
