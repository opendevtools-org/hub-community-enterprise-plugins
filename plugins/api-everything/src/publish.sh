#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
official=ghcr.io/opendevtools-org/api-everything:official
custom=ghcr.io/opendevtools-org/api-everything:enterprise

docker build -f "$root/official/Dockerfile" -t "$official" "$root/official"
docker push "$official"
docker build -f "$root/src/Dockerfile" -t "$custom" "$root"
docker push "$custom"
echo "$custom"
