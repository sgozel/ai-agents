#!/usr/bin/env bash
# Shared setup for every agent container
# called from each agent's postCreate.sh
set -euo pipefail

packages=(
    vim
    poppler-utils
    cmake
    tree
    ## C++ libs
    #libboost-dev
    #libmpfr-dev
    ## C++ testing
    #libgtest-dev
    ## latex
    #texlive
    #texlive-latex-extra
    #texlive-science
    #texlive-publishers
    #dvipng
    #cm-super
    #latexmk
    #biber
)

sudo apt-get update
sudo apt-get install -y "${packages[@]}"

# uv, pinned to the host version
curl -LsSf https://astral.sh/uv/0.12.13/install.sh | sh

# sync the workspace's uv project, wherever it is mounted
mapfile -d '' locks < <(find . -name uv.lock -not -path '*/.*' -print0)
case ${#locks[@]} in
  0) echo "no uv project found, skipping uv sync" ;;
  1) (cd "$(dirname "${locks[0]}")" && ~/.local/bin/uv sync --locked) ;;
  *) echo "warning: several uv projects found, they would share one venv; skipping:"
     printf '  %s\n' "${locks[@]}" ;;
esac