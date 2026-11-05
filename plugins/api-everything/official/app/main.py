"""Official api-everything HTTP API. The enterprise image starts from this."""

from fastapi import FastAPI

app = FastAPI(
    title="api-everything",
    version="0.1.0",
    docs_url="/swagger",
    openapi_url="/openapi.json",
)


@app.get("/health")
def health() -> dict:
    return {"status": "ok"}


@app.get("/v1/capabilities")
def capabilities() -> dict:
    return {"rest": True, "cli": True, "mcp": True}
