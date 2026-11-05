ARG OFFICIAL_IMAGE=ghcr.io/opendevtools-org/api-everything:official
FROM ${OFFICIAL_IMAGE}

COPY src/cli /opt/opendevtools/cli
COPY src/mcp /opt/opendevtools/mcp
COPY openapi.yaml /opt/opendevtools/openapi.yaml
RUN chmod 0755 /opt/opendevtools/cli/plugin_cli.py /opt/opendevtools/mcp/server.py \
 && ln -sf /opt/opendevtools/cli/plugin_cli.py /usr/local/bin/plugin-cli \
 && ln -sf /opt/opendevtools/mcp/server.py /usr/local/bin/plugin-mcp

ENV PLUGIN_NAME=api-everything \
    PLUGIN_API_BASE=http://127.0.0.1:8080 \
    PLUGIN_HEALTH_PATH=/health
