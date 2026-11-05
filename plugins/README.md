# Community plugins

Each folder is one Home Lab Hub market plugin. Hub reads the index
[`catalog.json`](../catalog.json).

```
plugins/<id>/
  docker-compose.backend.yml     # Hub installs this
  homelab-plugin.json
  openapi.yaml                   # REST API
  src/Dockerfile                 # FROM the official image
  src/cli/                       # CLI
  src/mcp/                       # MCP server
  src/publish.sh                 # push ghcr.io/opendevtools-org/<id>:enterprise
  official/                      # official image, only if none exists yet
```

## Backend (server)

Market **Install** downloads `docker-compose.backend.yml` and includes it from
`docker-compose.apps.yml`.

## Web client (device)

Market **Client** downloads `docker-compose.frontend.yml` plus `clients/web/`
and runs that compose on the device, with `*_API_UPSTREAM` pointing at the server.

Do not put secrets in this repo. Site owners set them in their `.env`.
