# Key Bindings
# Emacs-style bindings for consistency with bash/zsh

# Completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# History navigation
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# Line editing (Emacs-style)
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Alt+d -Function KillWord
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+k -Function ForwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

# FZF integration (if PSFzf module loaded)
if (Get-Module PSFzf -ErrorAction SilentlyContinue) {
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Ctrl+f -ScriptBlock { Invoke-FzfTabCompletion }
}
