#!/usr/bin/env bash
set -euo pipefail

# the Claude volume starts owned by root
sudo chown -R vscode:vscode /home/vscode/.claude

bash "$(dirname "$0")/postCreate-common.sh"
