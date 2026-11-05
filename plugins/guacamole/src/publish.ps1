$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$custom = "ghcr.io/opendevtools-org/guacamole:enterprise"

docker build -f (Join-Path $root "src\Dockerfile") -t $custom $root
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker push $custom
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Output $custom
