#Requires -Version 5.1
<#
.SYNOPSIS
    Windows Dotfiles Installer
.DESCRIPTION
    Sets up PowerShell dotfiles by creating symlinks from ~/.config/powershell
    to the dotfiles repository.
.NOTES
    Run as Administrator for symlinks, or with -Copy flag to copy files instead.
#>

param(
    [switch]$Copy,      # Copy files instead of symlinks
    [switch]$Force,     # Overwrite existing files
    [switch]$WhatIf     # Show what would happen
)

$ErrorActionPreference = "Stop"

# Paths
$DotfilesPath = $PSScriptRoot
$ConfigPath = "$HOME\.config"
$PowerShellConfig = "$ConfigPath\powershell"
$StarshipConfig = "$ConfigPath\starship.toml"

Write-Host "`n🚀 Windows Dotfiles Installer" -ForegroundColor Cyan
Write-Host "================================`n" -ForegroundColor Cyan

# Check for admin (needed for symlinks)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $Copy -and -not $isAdmin) {
    Write-Host "⚠️  Not running as Administrator. Using -Copy mode." -ForegroundColor Yellow
    $Copy = $true
}

# Create config directory
if (-not (Test-Path $ConfigPath)) {
    Write-Host "📁 Creating $ConfigPath" -ForegroundColor Green
    if (-not $WhatIf) { New-Item -ItemType Directory -Path $ConfigPath -Force | Out-Null }
}

# Backup existing config
if (Test-Path $PowerShellConfig) {
    if ($Force) {
        Write-Host "🗑️  Removing existing PowerShell config" -ForegroundColor Yellow
        if (-not $WhatIf) { Remove-Item $PowerShellConfig -Recurse -Force }
    } else {
        $backup = "$PowerShellConfig.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Write-Host "📦 Backing up existing config to $backup" -ForegroundColor Yellow
        if (-not $WhatIf) { Move-Item $PowerShellConfig $backup }
    }
}

# Install PowerShell config
Write-Host "📝 Installing PowerShell config..." -ForegroundColor Green
if ($Copy) {
    if (-not $WhatIf) {
        Copy-Item "$DotfilesPath\powershell" $PowerShellConfig -Recurse -Force
    }
    Write-Host "   Copied to $PowerShellConfig" -ForegroundColor DarkGray
} else {
    if (-not $WhatIf) {
        New-Item -ItemType SymbolicLink -Path $PowerShellConfig -Target "$DotfilesPath\powershell" -Force | Out-Null
    }
    Write-Host "   Symlinked $PowerShellConfig -> $DotfilesPath\powershell" -ForegroundColor DarkGray
}

# Install Starship config
Write-Host "⭐ Installing Starship config..." -ForegroundColor Green
if (Test-Path $StarshipConfig) {
    if (-not $WhatIf) { Remove-Item $StarshipConfig -Force }
}
if ($Copy) {
    if (-not $WhatIf) {
        Copy-Item "$DotfilesPath\shared\starship.toml" $StarshipConfig -Force
    }
} else {
    if (-not $WhatIf) {
        New-Item -ItemType SymbolicLink -Path $StarshipConfig -Target "$DotfilesPath\shared\starship.toml" -Force | Out-Null
    }
}

# Update PowerShell profile
$ProfileContent = @"
# PowerShell Profile - Sources dotfiles
# Edit: code ~/.config/powershell

. "`$HOME\.config\powershell\init.ps1"
"@

Write-Host "📝 Updating PowerShell profile..." -ForegroundColor Green
$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) {
    if (-not $WhatIf) { New-Item -ItemType Directory -Path $profileDir -Force | Out-Null }
}
if (-not $WhatIf) {
    Set-Content -Path $PROFILE -Value $ProfileContent -Force
}
Write-Host "   Updated $PROFILE" -ForegroundColor DarkGray

# Summary
Write-Host "`n✅ Installation complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Restart PowerShell or run: . `$PROFILE" -ForegroundColor White
Write-Host "  2. Install dependencies (if not already):" -ForegroundColor White
Write-Host "     scoop install starship eza bat ripgrep fd fzf zoxide 7zip sudo" -ForegroundColor DarkGray
Write-Host "     scoop install scoop-search" -ForegroundColor DarkGray
Write-Host "     Install-Module Terminal-Icons, PSFzf, posh-git -Scope CurrentUser" -ForegroundColor DarkGray
Write-Host ""
