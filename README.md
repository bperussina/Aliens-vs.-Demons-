# Aliens vs. Demons

A spec-driven game. Specifications in this repo are the source of truth; code follows them.

## Tooling

- [GitHub Spec Kit](https://github.com/github/spec-kit) (`specify-cli` 0.16.3) — local library in `.specify/`
- Cursor skills in `.cursor/skills/` (`speckit-*` plus project workflow/environment/GitHub skills)
- GitHub remote: [bperussina/Aliens-vs.-Demons-](https://github.com/bperussina/Aliens-vs.-Demons-)

## Prerequisites

`uv`, Python 3.12 (via uv — not system Python 3.9), `specify`, and `gh` on `PATH` (`~/.local/bin`).

```bash
export PATH="$HOME/.local/bin:$PATH"
specify check
gh auth status
```

## Spec-driven workflow

In Cursor Agent:

1. `/speckit-constitution` — project principles
2. `/speckit-specify` — feature spec
3. `/speckit-plan` — implementation plan
4. `/speckit-tasks` — task list
5. `/speckit-implement` — build from tasks
