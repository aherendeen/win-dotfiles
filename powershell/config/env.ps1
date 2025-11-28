# Environment Variables
# No personal data - uses $HOME and $env for paths

$env:POWERSHELL_TELEMETRY_OPTOUT = 1

# Editor preferences
$env:EDITOR = "code --wait"
$env:VISUAL = "code --wait"

# XDG Base Directory (cross-platform standard)
$env:XDG_CONFIG_HOME = "$HOME\.config"
$env:XDG_DATA_HOME = "$HOME\.local\share"
$env:XDG_CACHE_HOME = "$HOME\.cache"
$env:DOTFILES = "$HOME\.dotfiles"

# Tool-specific settings
$env:BAT_THEME = "Dracula"
$env:FZF_DEFAULT_OPTS = @"
--height 40% 
--layout=reverse 
--border 
--color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#bd93f9
--color=fg:#f8f8f2,header:#6272a4,info:#ffb86c,pointer:#ff79c6
--color=marker:#ff79c6,fg+:#f8f8f2,prompt:#50fa7b,hl+:#bd93f9
"@ -replace "`n", ""

# Starship config location
$env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
