$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$official = "ghcr.io/opendevtools-org/api-everything:official"
$custom = "ghcr.io/opendevtools-org/api-everything:enterprise"

docker build -f (Join-Path $root "official\Dockerfile") -t $official (Join-Path $root "official")
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker push $official
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker build -f (Join-Path $root "src\Dockerfile") -t $custom $root
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker push $custom
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Output $custom
