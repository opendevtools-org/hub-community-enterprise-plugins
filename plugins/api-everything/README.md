# API Everything

Hub installs `ghcr.io/opendevtools-org/api-everything:enterprise`.

There is no upstream image for this plugin, so `official/` is the official image.
It is a small HTTP API: `/health`, `/v1/capabilities`, and Swagger at `/swagger`.

`src/` starts from that official image and adds the CLI and the MCP server.
The container command stays the REST API. The CLI and the MCP server are in the image:

```
plugin-cli health
plugin-cli get /v1/capabilities
plugin-mcp
```

`plugin-mcp` speaks MCP on standard input and calls the REST API.

## Publish

Log in once: `docker login ghcr.io`.

```
sh src/publish.sh
```

On Windows: `src\publish.ps1`.

The script builds `:official`, then `:enterprise` from it, and pushes both to
`ghcr.io/opendevtools-org`. Hub installs `:enterprise`.
