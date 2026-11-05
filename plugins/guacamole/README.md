# Apache Guacamole (Hub community plugin)

Wrapper around the published image [`flcontainers/guacamole`](https://hub.docker.com/r/flcontainers/guacamole)
(`linux/amd64` and `linux/arm64`). Upstream: [Apache Guacamole](https://guacamole.apache.org/).

Clientless remote desktop gateway: RDP, VNC, and SSH from a browser. The image
bundles the web application, **guacd**, and PostgreSQL on one HTTP port. Hub
does not need a separate device client compose.

Opened from Hub (`/p/guacamole/`), login is the **Hub session**. The proxy
injects the Hub username (`REMOTE_USER`); there is no second Guacamole
password. Creating a user in Hub also creates the matching Guacamole account.

The image still ships **guacadmin** / **guacadmin**. Change that password if you
ever open the container outside Hub. Through Hub you always enter as the Hub
username, so use a Hub **admin** to manage users and shares.

To reach the Hub host from a connection, use hostname `host.docker.internal`.

PostgreSQL data is a Docker named volume (`guacamole-config` → `/config`). Do
not bind-mount a host folder there: on Docker Desktop for Windows that often
leaves logs stuck on `Guacamole client waiting for DB`.

## Install

From Hub Market (`/market`), while logged in, click **Installa**.

- The **web client** opens in that same Hub (`/p/guacamole/`).
- The **backend** starts on the Platform server that Hub already points to.

Remote desktop sessions need WebSocket. If a session fails to connect through
`/p/guacamole/`, open the published localhost port (or a dedicated tunnel
hostname pointed at that port).

## Share connections

Each Hub user sees **only the connections they created**, until someone shares
them. The `hub-users` group can create connections and groups; it does not
inherit the catalog.

1. Create the person in **Hub → Users** (same username appears in Guacamole).
2. In Guacamole, sign in as a Hub **admin**.
3. Open **Settings → Users** (Hub admin has Guacamole system administer;
   other Hub users do not see this tab).
4. Select the username → **Permissions**.
5. Grant **Read** on a **connection group** or a single connection. Grant
   **Administer** if they should also edit it from Settings.

Save. The other user refreshes the home screen and sees the shared items.

This is catalog sharing (SSH/RDP/VNC entries). It is not a live screen share.

To share an **open session** (same desktop/terminal at the same time): add a
**Sharing profile** on the connection, then in the session
**Ctrl+Alt+Shift → Share**. That link is temporary and ends when the owner
disconnects.

## File browser (SFTP)

SSH connections can show a file browser. This is **SFTP over SSH**, not classic
FTP.

1. Edit the SSH connection → enable **SFTP**.
2. Use the same auth as SSH. If the host allows only public keys, set a
   **private key** (a dummy password is not enough).
3. In the session: **Ctrl+Alt+Shift** → folder / **Devices**. You can also
   drag-and-drop files onto the window.

## Enterprise image

Hub installs `ghcr.io/opendevtools-org/guacamole:enterprise`.

`src/Dockerfile` starts from `flcontainers/guacamole:latest` and copies in the
CLI, the MCP server, and `openapi.yaml`. It does not replace the Guacamole
command. The REST API is the one Guacamole already serves. Swagger for that
API is the OpenAPI file in this folder.

Inside the container:

```
plugin-cli health
plugin-mcp
```

Log in once with `docker login ghcr.io`, then publish with `sh src/publish.sh`
(or `src\publish.ps1` on Windows). The script pushes the enterprise tag.
Hub installs that tag.
