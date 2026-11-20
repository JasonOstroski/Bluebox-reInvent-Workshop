# Workshop Shop

A small, editable ecommerce application for workshops. It has a browser frontend, shop API, PostgreSQL database, PostgREST data gateway, and separate mock payment service. The application source is mounted into prebuilt Node containers, so there are no application image builds.

## GitHub Codespaces

Create a Codespace from this repository. On creation (and container rebuild),
Codespaces installs the latest Bluebox CLI automatically, verifies its SHA-256
checksum before installation, exposes it on `PATH` to all container processes,
and installs Bluebox skills for GitHub Copilot in `.github/skills/`. There are
no setup prompts, browser sign-in, or automatic application startup. Rebuild
the Codespace after changing the devcontainer configuration so the agent and
terminals receive the updated environment and skills.

For non-interactive authentication, create a Bluebox access token under
**Account > Access tokens**, then add it as a GitHub **Codespaces secret** named
`BLUEBOX_TOKEN`. Grant that secret access to this new workshop repository before
creating the Codespace. Use Codespaces secrets, not Actions secrets or committed
environment files. Each participant should use their own token.

Add these two Codespaces secrets for telemetry, also granting them access to
this repository before creating the Codespace:

| Secret | Value |
| --- | --- |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | OTLP ingest endpoint URL from Bluebox Setup. |
| `OTEL_EXPORTER_OTLP_HEADERS` | Full authentication header value from Bluebox Setup, without angle brackets. |

The Codespaces configuration recommends all three secrets during creation.
GitHub injects their values as environment variables; no values are stored in
this repository. Run `make up` in the Codespace to start the app with telemetry:
Compose already forwards the two OTel variables to the shop and payment services.
If you add or change a secret in an existing Codespace, stop and restart it to
pick up the new value.

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
