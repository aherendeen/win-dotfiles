# PowerShell Dotfiles - Main Loader
# Source: https://github.com/YOUR_USERNAME/win-dotfiles
# Location: ~/.config/powershell/init.ps1

$DOTFILES_PS = "$HOME\.config\powershell"

#region Module Loading
Import-Module Terminal-Icons -ErrorAction SilentlyContinue
Import-Module posh-git -ErrorAction SilentlyContinue
Import-Module PSFzf -ErrorAction SilentlyContinue
#endregion

#region Configuration Loading
. "$DOTFILES_PS\config\env.ps1"
. "$DOTFILES_PS\config\psreadline.ps1"
. "$DOTFILES_PS\config\keybindings.ps1"
#endregion

#region Function Loading
# Auto-load all function files
Get-ChildItem "$DOTFILES_PS\functions\*.ps1" -ErrorAction SilentlyContinue | 
    ForEach-Object { . $_.FullName }
#endregion

#region Shell Integrations
# Zoxide - smarter cd command
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# Starship - cross-shell prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    Invoke-Expression (&starship init powershell)
}
#endregion

#region Startup
# Minimal startup message
$wslStatus = if (Get-Command wsl.exe -ErrorAction SilentlyContinue) { "✓" } else { "✗" }
Write-Host "pwsh $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor) | WSL: $wslStatus" -ForegroundColor DarkGray
#endregion
