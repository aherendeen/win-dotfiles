# General Utilities
# Network, system, and file utilities

#region Network
function ip { (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content }
function localip { 
    (Get-NetIPAddress -AddressFamily IPv4 | 
     Where-Object { $_.InterfaceAlias -notmatch "Loopback" -and $_.PrefixOrigin -ne "WellKnown" }).IPAddress 
}
function ports { netstat -an | Select-String "LISTENING" }
function flushdns { Clear-DnsClientCache; Write-Host "DNS cache flushed" -ForegroundColor Green }

function killport {
    param([int]$port)
    $conn = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($conn) {
        Stop-Process -Id $conn.OwningProcess -Force
        Write-Host "Killed process on port $port" -ForegroundColor Green
    } else {
        Write-Host "No process found on port $port" -ForegroundColor Yellow
    }
}

function listening {
    Get-NetTCPConnection -State Listen | 
    Select-Object LocalAddress, LocalPort, OwningProcess, 
        @{N='Process'; E={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName}} | 
    Sort-Object LocalPort
}
#endregion

#region System
function reload { . $PROFILE; Write-Host "Profile reloaded" -ForegroundColor Green }
function path { $env:PATH -split ";" | Where-Object { $_ } }
function envs { Get-ChildItem Env: | Sort-Object Name | Format-Table -AutoSize }
function uptime { (Get-CimInstance Win32_OperatingSystem).LastBootUpTime }
function sysinfo { Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer }
#endregion

#region File utilities
function sha256 { param($file) (Get-FileHash $file -Algorithm SHA256).Hash.ToLower() }
function md5 { param($file) (Get-FileHash $file -Algorithm MD5).Hash.ToLower() }

function sizeof {
    param([string]$path = ".")
    $size = (Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue | 
             Measure-Object -Property Length -Sum).Sum
    "{0:N2} MB" -f ($size / 1MB)
}

function duh {
    Get-ChildItem -Directory | ForEach-Object {
        $size = (Get-ChildItem $_.FullName -Recurse -ErrorAction SilentlyContinue | 
                 Measure-Object -Property Length -Sum).Sum
        [PSCustomObject]@{ 
            Name = $_.Name
            Size = "{0:N2} MB" -f ($size / 1MB)
            Bytes = $size
        }
    } | Sort-Object Bytes -Descending | Select-Object Name, Size
}

function extract {
    param([string]$file)
    if (-not (Test-Path $file)) {
        Write-Host "File not found: $file" -ForegroundColor Red
        return
    }
    $dest = [System.IO.Path]::GetDirectoryName($file)
    switch -Regex ($file) {
        '\.zip$' { Expand-Archive $file -DestinationPath $dest -Force }
        '\.(tar\.gz|tgz)$' { tar -xzf $file -C $dest }
        '\.(tar\.bz2|tbz2)$' { tar -xjf $file -C $dest }
        '\.tar$' { tar -xf $file -C $dest }
        '\.(7z|rar)$' { 7z x $file -o"$dest" -y }
        default { Write-Host "Unknown archive: $file" -ForegroundColor Red }
    }
}
#endregion

#region Process management
function psg { param($name) Get-Process | Where-Object { $_.ProcessName -match $name } }
function pkill { param($name) Get-Process | Where-Object { $_.ProcessName -match $name } | Stop-Process -Force }
function pstree { Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 Name, Id, CPU, @{N='Mem(MB)';E={[math]::Round($_.WorkingSet64/1MB,1)}} }
#endregion

#region Misc utilities
function weather { param($loc = "") (Invoke-WebRequest "wttr.in/$loc`?format=3" -UseBasicParsing).Content }
function cpy { Set-Clipboard @args }
function pst { Get-Clipboard }
function serve { param($port = 8000) python -m http.server $port }
function uuid { [guid]::NewGuid().ToString() }
function now { Get-Date -Format "yyyy-MM-dd HH:mm:ss" }
function epoch { [DateTimeOffset]::Now.ToUnixTimeSeconds() }
#endregion
