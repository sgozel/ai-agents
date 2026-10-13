#!/usr/bin/env bash
set -euo pipefail

# the auth.json bind mount makes the runtime create ~/.local/share/opencode owned by root
sudo install -d -o vscode -g vscode \
  /home/vscode/.local /home/vscode/.local/share /home/vscode/.local/share/opencode

bash "$(dirname "$0")/postCreate-common.sh"

# opencode (installs to ~/.opencode/bin)
curl -fsSL https://opencode.ai/install | bash
