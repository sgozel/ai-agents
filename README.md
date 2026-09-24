# AI Agents setup

This repository contains the `devcontainer` setup of two AI Agents (`opencode`, `claude-code`) using a `podman` container backend in VS Code.

## Quick setup

The `bin/ai-agent` script copies an agent's files into a working directory, or removes them again. Add these aliases to `~/.bash_aliases` on the host (adjust the path to where this repo is cloned):

```bash
alias ai-agent-claude='~/software/ai-agents/bin/ai-agent claude'
alias ai-agent-opencode='~/software/ai-agents/bin/ai-agent opencode'
alias ai-agent-clean='~/software/ai-agents/bin/ai-agent clean'
```

Usage (the directory defaults to `.`):

```bash
ai-agent-claude ~/work_agent/agentA     # copy .devcontainer/ and .claude/
ai-agent-opencode .                     # copy .devcontainer/ and opencode.jsonc
ai-agent-opencode --force .             # overwrite files that already exist
ai-agent-clean .                        # remove .devcontainer/, .claude/, opencode.jsonc (asks first)
ai-agent-clean -y .                     # remove without asking
```

The manual steps below still work.

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
