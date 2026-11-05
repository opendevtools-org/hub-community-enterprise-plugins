# Hub Community Plugins

Curated catalog for Home Lab Hub market.

Default Hub URL:

```
https://raw.githubusercontent.com/opendevtools-org/hub-community-enterprise-plugins/main/catalog.json
```

Hub lists public plugins from `catalog.json`. Each plugin’s **backend** Compose file lives under [`plugins/<id>/`](plugins/). Web clients live under `plugins/<id>/clients/` plus `docker-compose.frontend.yml`.

## Layout

```
catalog.json
plugins/<id>/docker-compose.backend.yml    # what Hub installs
plugins/<id>/homelab-plugin.json
plugins/<id>/openapi.yaml                  # REST API
plugins/<id>/src/cli/                      # CLI copied into the image
plugins/<id>/src/mcp/                      # MCP server copied into the image
plugins/<id>/src/Dockerfile                # FROM the official image
plugins/<id>/src/publish.sh                # build and push :enterprise
plugins/<id>/official/                     # only when no official image exists
```

Hub installs `ghcr.io/opendevtools-org/<id>:enterprise`. `src/publish.sh` builds
that tag from the official image and pushes it. The enterprise image keeps the
REST API as the container command and also contains `plugin-cli` and `plugin-mcp`.

`docker-compose.yml` may exist as an alias that includes the backend file.

## Backend vs client

| Where | File | Role |
|-------|------|------|
| Server | `docker-compose.backend.yml` | API / workers. Market **Install** copies this into `docker-compose.apps.yml`. |
| Device | `docker-compose.frontend.yml` | Web client. Reverse-proxies to `*_API_UPSTREAM`. Not started on the server. |

If `install.command` is omitted and `install.composeFile` is `plugins/<id>/docker-compose.backend.yml`, Hub derives the backend command. If a client has `composeFile`, Hub derives the device command (standalone `docker compose -f … up`, not the apps overlay).

Private plugins do not belong here (use Hub `market-private.json` on the site).

Published by OpenDevTools.
