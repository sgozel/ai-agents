# AI Agents setup

This repository contains the `devcontainer` setup of two AI Agents (`opencode`, `claude-code`) using a `podman` container backend in VS Code.

## Quick setup

The `bin/ai-agent` script copies an agent's files into a working directory, or removes them again. Add these aliases to `~/.bash_aliases` on the host (adjust the path to where this repo is cloned):

```bash
alias ai-agent-claude='~/software/ai-agents/bin/ai-agent claude'
alias ai-agent-opencode='~/software/ai-agents/bin/ai-agent opencode'
alias ai-agent-opencode2='~/software/ai-agents/bin/ai-agent opencode2'
alias ai-agent-clean='~/software/ai-agents/bin/ai-agent clean'
```

Usage (the directory defaults to `.`):

```bash
ai-agent-claude ~/work_agent/agentA     # copy .devcontainer/ and .claude/
ai-agent-opencode .                     # copy .devcontainer/ and opencode.jsonc
ai-agent-opencode2 .                    # copy .devcontainer/ and opencode.jsonc
ai-agent-opencode --force .             # overwrite files that already exist
ai-agent-clean .                        # remove .devcontainer/, .claude/, opencode.jsonc (asks first)
ai-agent-clean -y .                     # remove without asking
```

Update the mounts in `.devcontainer/devcontiner.json` (inside the working folder) and the post create installs (in `.devcontainer/postCreate-common.sh`) before proceeding to the container build.

## Manual setup

This is kept for reference. Better used the automated setup `ai-agent-...`.

### Claude-code

To run a `claude-code` agent in a given working directory:
- Copy-paste the `.devcontainer/` folder inside the working directory
- Copy-paste the `common/postCreate-common.sh` file inside `.devcontainer` in the working directory
- Copy-paste the `.claude/` folder inside the working directory
- Build and run the container in VS Code
- call `claude` on the command-line

*Note*: The `claude-code` agent validates the API key by requesting a login to the Claude account on first build. On successive build, the credentials are read from a volume mount.

### Opencode

 The `opencode` agent is using the CSCS internal inference service. The API key is mounted from the host into the container.

To run an `opencode` agent in a given working directory:
- Copy-paste the `.devcontainer/` folder inside the working directory
- Copy-paste the `common/postCreate-common.sh` file inside `.devcontainer` in the working directory
- Copy-paste the `opencode/opencode.jsonc` file inside the working directory
- Build and run the container in VS Code
- call `opencode` on the command-line

*Note*: The host bind-mounts (in readonly mode) the `auth.json` file containing the API key. The `opencode.jsonc` is shared by v1 and v2, and lives one level above the version folder. The `ai-agent` script copies it automatically.

### Opencode2

 The `opencode2` agent is using the CSCS internal inference service. The API key is mounted from the host into the container.

To run an `opencode2` agent in a given working directory:
- Copy-paste the `.devcontainer/` folder inside the working directory
- Copy-paste the `common/postCreate-common.sh` file inside `.devcontainer` in the working directory
- Copy-paste the `opencode/opencode.jsonc` file inside the working directory
- Build and run the container in VS Code
- call `opencode` on the command-line

*Note*: The host bind-mounts (in readonly mode) the `auth.json` file containing the API key. The secret is introduced at build time in `.config/opencode/opencode.json` as required by opencode v2 (see `postCreate.sh`). The `opencode.jsonc` is shared by v1 and v2.