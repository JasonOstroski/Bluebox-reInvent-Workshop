# Workshop Shop

A small, editable ecommerce application for workshops. It has a browser frontend, shop API, PostgreSQL database, PostgREST data gateway, and separate mock payment service. The application source is mounted into prebuilt Node containers, so there are no application image builds.

## GitHub Codespaces

Create a Codespace from this repository. On creation (and container rebuild),
Codespaces installs the latest Bluebox CLI automatically, verifies its SHA-256
checksum before installation, and adds it to the terminal PATH. There are no
setup prompts, browser sign-in, or automatic application startup.

For non-interactive authentication, create a Bluebox access token under
**Account > Access tokens**, then add it as a GitHub **Codespaces secret** named
`BLUEBOX_TOKEN`. Grant that secret access to this new workshop repository before
creating the Codespace. Use Codespaces secrets, not Actions secrets or committed
environment files. Each participant should use their own token.

The installation script removes the token from its own environment before
downloading anything. The CLI reads the secret from the Codespace environment
when you run commands; no login or token file is needed.

Verify installation in a new terminal:

```bash
bluebox version
```

If your account has multiple Bluebox workspaces, select one without prompts:

```bash
bluebox workspace list
bluebox workspace switch <workspace-id>
```

To retry a failed installation, run `bash .devcontainer/install-bluebox.sh`.
See the [Bluebox CLI documentation](https://docs.bluebox.ai/cli) for details.

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
# Paste your values — the endpoint can also be fetched by the CLI
export OTEL_EXPORTER_OTLP_ENDPOINT="https://<your-endpoint-from-bluebox-setup>"

# Paste the full header value from Bluebox Setup (do not include angle brackets)
export OTEL_EXPORTER_OTLP_HEADERS="<header value from Bluebox Setup>"

# Start the app (pulls images, waits for readiness)
make up
```
