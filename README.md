# Workshop Shop

A small, editable ecommerce application for workshops. It has a browser frontend, shop API, PostgreSQL database, PostgREST data gateway, and separate mock payment service. The application source is mounted into prebuilt Node containers, so there are no application image builds.

## GitHub Codespaces

Add these two GitHub **Codespaces secrets** and grant them access to this
repository:

| Secret | Value |
| --- | --- |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | OTLP ingest endpoint URL from Bluebox Setup. |
| `OTEL_EXPORTER_OTLP_HEADERS` | Full authentication header value from Bluebox Setup, without angle brackets. |

GitHub injects these secret values as environment variables; no values are
stored in this repository. Run `make up` in the Codespace to start the app with
telemetry. Compose forwards both variables to the shop and payment services. If
you add or change a secret in an existing Codespace, stop and restart it to pick
up the new value.

## Run locally

To start the app:

```bash
make up
```

To stop the app:

```bash
make down
```

### OTel

If you want OTel, use:

```bash
# Paste the OTLP endpoint from Bluebox Setup
export OTEL_EXPORTER_OTLP_ENDPOINT="https://<your-endpoint-from-bluebox-setup>"

# Paste the full header value from Bluebox Setup (do not include angle brackets)
export OTEL_EXPORTER_OTLP_HEADERS="<header value from Bluebox Setup>"

# Start the app (pulls images, waits for readiness)
make up
```
