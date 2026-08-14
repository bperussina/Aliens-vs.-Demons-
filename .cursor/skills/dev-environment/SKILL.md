---
name: dev-environment
description: Local toolchain and repo layout for Aliens vs. Demons. Use when installing tools, fixing PATH, running specify/uv/python/gh, bootstrapping a machine, or diagnosing environment issues.
---

# Dev Environment

Work from the repository root: `/Users/brodyperussina/Code/Aliens-vs.-Demons-`.

## PATH

User tools install to `~/.local/bin`. Ensure it is on PATH before running CLI tools:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

If `uv`, `specify`, or `gh` is "not found", fix PATH first. Do not reinstall.

## Toolchain

| Tool | Role | Notes |
| --- | --- | --- |
| `gh` | GitHub CLI | Installed at `~/.local/bin/gh` |
| `uv` | Python + tool installer | Installed at `~/.local/bin/uv` |
| `python3.12` | Runtime for specify-cli | Managed by uv; **do not use** system `/usr/bin/python3` (3.9) |
| `specify` | GitHub Spec Kit CLI | `specify-cli` 0.16.3 via `uv tool install specify-cli` |

Verify:

```bash
uv --version
python3.12 --version
specify --version
specify check
gh --version
gh auth status
```

## Install / repair

```bash
# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Python 3.12 (required; specify needs 3.11+)
uv python install 3.12

# Spec Kit CLI
uv tool install specify-cli

# Re-scaffold this repo (only when asked)
specify init --here --force --integration cursor-agent --script sh
```

## Repo layout

```
.specify/                 # Local Spec Kit library (templates, scripts, constitution)
.cursor/skills/           # Agent skills (speckit-* plus project skills)
specs/                    # Feature specs (created later)
.gitignore
```

- Scripts: `.specify/scripts/bash/` (`sh`, executable).
- Do not commit `.env`, credentials, or `.cursor/` except `.cursor/skills/`.
- Feature work belongs in `specs/` and application source, not inside `.specify/templates/`.

## Conventions

- Prefer `uv` for Python tools and versions. Do not introduce conda/pyenv unless the user asks.
- Homebrew is not installed on this machine; do not assume `brew`.
- Shell is zsh on macOS darwin.
- Keep toolchain upgrades out of gameplay/feature commits.
