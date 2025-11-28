# Directory Navigation
# Quick directory jumping and creation

#region Parent directory shortcuts
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }
function ~ { Set-Location $HOME }
function - { Set-Location - }
#endregion

#region Directory creation
function mkcd {
    param([string]$dir)
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Set-Location $dir
}
function take { param([string]$dir) mkcd $dir }
#endregion

#region Quick directory shortcuts
# These use $HOME to avoid hardcoded paths
function dev { Set-Location "$HOME\dev" }
function repos { Set-Location "$HOME\repos" }
function docs { Set-Location "$HOME\Documents" }
function dl { Set-Location "$HOME\Downloads" }
function desk { Set-Location "$HOME\Desktop" }
function dotfiles { Set-Location "$env:DOTFILES" }
#endregion

#region File operations
function trash {
    param([string]$path)
    if (Test-Path $path) {
        Remove-Item $path -Recurse -Force
    } else {
        Write-Host "Path not found: $path" -ForegroundColor Red
    }
}

function touch {
    param([string]$file)
    if (Test-Path $file) {
        (Get-Item $file).LastWriteTime = Get-Date
    } else {
        New-Item -ItemType File -Path $file | Out-Null
    }
}
#endregion
