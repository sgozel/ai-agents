# AI Agents setup

This repository contains the `devcontainer` setup of two AI Agents (`opencode`, `claude-code`) using a `podman` container backend in VS Code.


## Claude-code

To run a `claude-code` agent in a given working directory:
- Copy-paste the `.devcontainer/` folder inside the working directory
- Copy-paste the `.claude/` folder inside the working directory
- Build and run the container in VS Code
- call `claude` on the command-line

*Note*: The `claude-code` agent validates the API key by requesting a login to the Claude account.

## Opencode

 The `opencode` agent is using the CSCS internal inference service. The API key is mounted from the host into the container.

To run an `opencode` agent in a given working directory:
- Copy-paste the `.devcontainer/` folder inside the working directory
- Copy-paste the `opencode.jsonc` file inside the working directory
- Build and run the container in VS Code
- call `opencode` on the command-line

*Note*: The host bind-mounts (in readonly mode) the `auth.json` file containing the API key.
