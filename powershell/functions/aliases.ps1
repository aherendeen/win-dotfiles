# Aliases & Modern CLI Tools
# Requires: eza, bat, ripgrep, fd (install via scoop)

#region EZA (modern ls)
function l { eza --icons -a @args }
function ls { eza --icons @args }
function ll { eza --icons -la @args }
function la { eza --icons -a @args }
function lt { eza --icons --tree --level=2 @args }
function llt { eza --icons -la --tree --level=2 @args }
#endregion

#region Modern CLI replacements
Set-Alias -Name cat -Value bat -Option AllScope -ErrorAction SilentlyContinue
Set-Alias -Name grep -Value rg -Option AllScope -ErrorAction SilentlyContinue
Set-Alias -Name find -Value fd -Option AllScope -ErrorAction SilentlyContinue
Set-Alias -Name which -Value Get-Command -Option AllScope
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
#endregion

#region Config editing (uses $EDITOR or defaults to code)
function Edit-Profile { & $env:EDITOR $PROFILE }
function Edit-Dotfiles { & $env:EDITOR "$env:DOTFILES" }
function Edit-GitConfig { & $env:EDITOR "$HOME\.gitconfig" }
function Edit-SSHConfig { & $env:EDITOR "$HOME\.ssh\config" }
function Edit-Hosts { sudo notepad "$env:SystemRoot\System32\drivers\etc\hosts" }
function Edit-Starship { & $env:EDITOR "$HOME\.config\starship.toml" }

Set-Alias -Name ep -Value Edit-Profile
Set-Alias -Name edf -Value Edit-Dotfiles
#endregion
