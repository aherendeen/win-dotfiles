# Docker via WSL Ubuntu
# Routes all Docker commands to Docker Engine running in WSL Ubuntu

#region Core Docker commands (via WSL)
function docker { wsl.exe docker @args }
function d { wsl.exe docker @args }
function dc { wsl.exe docker compose @args }
function dps { wsl.exe docker ps @args }
function dpsa { wsl.exe docker ps -a }
function dimg { wsl.exe docker images }
function dprune { wsl.exe docker system prune -af }
#endregion

#region Container management
function dlogs { param($c) wsl.exe docker logs -f $c }
function dexec { param($c) wsl.exe docker exec -it $c /bin/bash }
function dsh { param($c) wsl.exe docker exec -it $c /bin/sh }
function dstop { wsl.exe bash -c 'docker stop $(docker ps -q)' }
function drm { wsl.exe bash -c 'docker rm $(docker ps -aq)' }
function drmi { wsl.exe bash -c 'docker rmi $(docker images -q)' }
function dinspect { param($c) wsl.exe docker inspect $c }
function dstats { wsl.exe docker stats @args }
#endregion

#region Docker Compose shortcuts
function dcu { wsl.exe docker compose up -d @args }
function dcd { wsl.exe docker compose down @args }
function dcl { wsl.exe docker compose logs -f @args }
function dcr { wsl.exe docker compose restart @args }
function dcb { wsl.exe docker compose build @args }
function dce { wsl.exe docker compose exec @args }
function dcps { wsl.exe docker compose ps }
#endregion

#region Docker context and info
function dinfo { wsl.exe docker info }
function dver { wsl.exe docker version }
function ddf { wsl.exe docker system df }
#endregion

#region Volume and network management
function dvls { wsl.exe docker volume ls }
function dnls { wsl.exe docker network ls }
function dvrm { param($v) wsl.exe docker volume rm $v }
function dnrm { param($n) wsl.exe docker network rm $n }
#endregion
