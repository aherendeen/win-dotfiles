# WSL/Ubuntu Integration
# Seamless Windows <-> WSL workflows

#region WSL Access
function wsl { wsl.exe @args }
function ubuntu { wsl.exe -d Ubuntu @args }
function debian { wsl.exe -d Debian @args }
function wsllist { wsl.exe --list --verbose }
function wslshutdown { wsl.exe --shutdown }
#endregion

#region Run commands in WSL
function wslrun {
    param([string]$cmd)
    wsl.exe bash -c $cmd
}

function bash {
    if ($args) {
        wsl.exe bash -c "$args"
    } else {
        wsl.exe bash
    }
}
#endregion

#region Path conversion and navigation
function wslhome { Set-Location "\\wsl$\Ubuntu\home\$env:USERNAME" }
function wslroot { Set-Location "\\wsl$\Ubuntu" }

function cdwsl {
    # Open current Windows directory in WSL bash
    $wslPath = (Get-Location).Path -replace '\\', '/' -replace '^([A-Za-z]):', { '/mnt/' + $_.Groups[1].Value.ToLower() }
    wsl.exe bash -c "cd '$wslPath' && exec bash"
}

function winpath {
    # Convert WSL path to Windows path
    param([string]$wslPath)
    wsl.exe wslpath -w $wslPath
}

function wslpath {
    # Convert Windows path to WSL path
    param([string]$winPath)
    wsl.exe wslpath -u $winPath
}
#endregion

#region File transfer
function towsl {
    param(
        [string]$src,
        [string]$dest = "~/"
    )
    $wslSrc = wsl.exe wslpath -u "'$src'"
    wsl.exe cp -r $wslSrc $dest
}

function fromwsl {
    param(
        [string]$src,
        [string]$dest = "."
    )
    Copy-Item "\\wsl$\Ubuntu$src" $dest -Recurse
}
#endregion

#region Ubuntu package management (via WSL)
function aptup { wsl.exe sudo apt update '&&' sudo apt upgrade -y }
function apti { wsl.exe sudo apt install -y @args }
function apts { wsl.exe apt search @args }
function aptr { wsl.exe sudo apt remove @args }
function aptc { wsl.exe sudo apt autoremove -y '&&' sudo apt autoclean }
#endregion

#region WSL utilities
function wslip { 
    $ip = (wsl.exe hostname -I).Trim().Split()[0]
    Write-Host "WSL IP: $ip" -ForegroundColor Cyan
    $ip
}

function wslmem {
    # Show WSL memory usage
    wsl.exe free -h
}

function wsldf {
    # Show WSL disk usage
    wsl.exe df -h /
}
#endregion

#region SSH into WSL services
function wssh {
    param([int]$port = 22)
    $ip = (wsl.exe hostname -I).Trim().Split()[0]
    ssh "$env:USERNAME@$ip" -p $port
}
#endregion
