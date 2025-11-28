# Docker Shortcuts
# Works with Docker Desktop (native or WSL 2 backend)

function d { docker @args }
function dc { docker compose @args }
function dps { docker ps @args }
function dpsa { docker ps -a }
function dimg { docker images }
function dprune { docker system prune -af }

# Container management
function dlogs { param($c) docker logs -f $c }
function dexec { param($c) docker exec -it $c /bin/bash }
function dsh { param($c) docker exec -it $c /bin/sh }
function dstop { docker stop $(docker ps -q) }
function drm { docker rm $(docker ps -aq) }
function drmi { docker rmi $(docker images -q) }

# Docker Compose shortcuts
function dcu { docker compose up -d @args }
function dcd { docker compose down @args }
function dcl { docker compose logs -f @args }
function dcr { docker compose restart @args }
function dcb { docker compose build @args }
