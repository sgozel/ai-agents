#!/usr/bin/env bash
set -euo pipefail

# the Codex volume starts owned by root
sudo chown -R vscode:vscode /home/vscode/.codex

bash "$(dirname "$0")/postCreate-common.sh"

# bubblewrap: Codex's Linux sandbox prefers the system bwrap
sudo apt-get install -y bubblewrap

# Codex CLI
npm install -g @openai/codex

# Trust this workspace, so Codex loads the project's .codex/ (config + rules)
# without asking. The decision is stored in the persisted volume
cfg="${CODEX_HOME:-$HOME/.codex}/config.toml"
ws="$(pwd)"
touch "$cfg"
if ! grep -qF "[projects.\"$ws\"]" "$cfg"; then
  printf '\n[projects."%s"]\ntrust_level = "trusted"\n' "$ws" >> "$cfg"
fi