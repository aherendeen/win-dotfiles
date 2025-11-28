# Scoop Package Manager
# Windows package manager helpers

#region Fast search hook (requires scoop-search)
if (Get-Command scoop-search -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (scoop-search --hook | Out-String) })
}
#endregion

#region Package management
function si { scoop install @args }
function sr { scoop uninstall @args }
function su { 
    if ($args) { scoop update @args } 
    else { scoop update } 
}
function sua { scoop update '*' }
function sl { scoop list }
function sinfo { scoop info @args }
function shome { scoop home @args }
function swhich { scoop which @args }
#endregion

#region Bucket management
function sbucket { scoop bucket add @args }
function sblist { scoop bucket list }
function sbrm { scoop bucket rm @args }
#endregion

#region Maintenance
function sclean { 
    Write-Host "Cleaning scoop cache and old versions..." -ForegroundColor Cyan
    scoop cleanup '*'
    scoop cache rm '*'
}
function sstatus { scoop status }
function scheckup { scoop checkup }
#endregion

#region Search helpers
function ssearch { scoop search @args }
#endregion
