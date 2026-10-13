#!/usr/bin/env bash
set -euo pipefail

# the auth.json bind mount makes the runtime create ~/.local/share/opencode owned by root
sudo install -d -o vscode -g vscode \
  /home/vscode/.local /home/vscode/.local/share /home/vscode/.local/share/opencode

bash "$(dirname "$0")/postCreate-common.sh"

# opencode v2 (installs to ~/.opencode/bin/)
curl -fsSL https://opencode.ai/v2/install | bash

# Migrate the v1 auth.json CSCS API key into a v2 global config
# This keeps secrets out of the repo while giving opencode v2 the credential
# shape it expects (provider.<name>.options.apiKey).

# Ensure jq is available for JSON parsing.
if ! command -v jq >/dev/null 2>&1; then
  sudo apt-get update >/dev/null
  sudo apt-get install -y jq >/dev/null
fi

sudo install -d -o vscode -g vscode -m 700 /home/vscode/.config/opencode

AUTH_FILE="$HOME/.local/share/opencode/auth.json"
CONFIG_FILE="$HOME/.config/opencode/opencode.json"

if [ ! -f "$AUTH_FILE" ]; then
  echo "Warning: $AUTH_FILE not found; skipping API key migration."
  exit 0
fi

if ! KEY=$(jq -er '.cscs.key // empty' "$AUTH_FILE" 2>/dev/null); then
  echo "Warning: $AUTH_FILE has no cscs.key; skipping API key migration."
  exit 0
fi

if [ -z "$KEY" ]; then
  echo "Warning: cscs.key is empty; skipping API key migration."
  exit 0
fi

jq -n \
  --arg key "$KEY" \
  '{
    "$schema": "https://opencode.ai/config.json",
    provider: {
      cscs: {
        options: {
          apiKey: $key
        }
      }
    }
  }' > "$CONFIG_FILE"

chmod 600 "$CONFIG_FILE"
echo "Migrated cscs API key to $CONFIG_FILE"