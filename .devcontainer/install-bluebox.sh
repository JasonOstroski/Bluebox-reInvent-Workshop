#!/usr/bin/env bash
set -euo pipefail

unset BLUEBOX_TOKEN

case "$(uname -s)" in
  Linux) os=linux ;;
  *) printf 'Bluebox Codespaces installation requires Linux.\n' >&2; exit 1 ;;
esac

case "$(uname -m)" in
  x86_64) arch=amd64 ;;
  aarch64|arm64) arch=arm64 ;;
  *) printf 'Unsupported CPU architecture.\n' >&2; exit 1 ;;
esac

for dependency in curl jq sha256sum; do
  command -v "$dependency" >/dev/null || {
    printf 'Missing required command: %s\n' "$dependency" >&2
    exit 1
  }
done

install_dir="$HOME/.bluebox/bin"
mkdir -p "$install_dir"
download_dir="$(mktemp -d "$install_dir/.install-XXXXXX")"
trap 'rm -rf "$download_dir"' EXIT

metadata="$(curl -fsS --retry 3 --connect-timeout 15 --max-time 120 --proto '=https' \
  "https://app.bluebox.ai/v1/cli/latest?os=$os&arch=$arch")"
download_url="$(printf '%s' "$metadata" | jq -er '.download_url | strings | select(length > 0)')"
checksum="$(printf '%s' "$metadata" | jq -er '.sha256 | strings | select(test("^[0-9a-fA-F]{64}$"))')"

curl -fsSL --retry 3 --connect-timeout 15 --max-time 300 --proto '=https' --proto-redir '=https' \
  -o "$download_dir/bluebox" "$download_url"
printf '%s  %s\n' "$checksum" "$download_dir/bluebox" | sha256sum -c - >/dev/null
chmod 755 "$download_dir/bluebox"
mv -f "$download_dir/bluebox" "$install_dir/bluebox"
printf 'Bluebox CLI installed.\n'