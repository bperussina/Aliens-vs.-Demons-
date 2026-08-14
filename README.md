# Aliens vs. Demons

You are the robot. Protect the king. Demons look like people with robot eyes. The camera plays like Vampire Survivors. The look is smooth illustration, never pixel art.

A spec-driven game. Specifications in this repo are the source of truth; code follows them.

**Stack:** Godot **4.7.1** (2D) + GDScript. Open this folder in Godot and press Play.
**Baseline spec:** `specs/001-king-protector/spec.md`.

## Play

1. Open **Godot 4.7.1** (`/Applications/Godot.app`).
2. Import this repo folder.
3. Press **Play** (F5). You should see a **green title menu**.
4. **Single Player** loads the match. The king **is** the computer. Walk with WASD to aim the head-wire; bullets come out of the wire. **Esc** returns to the menu.

```bash
export PATH="$HOME/.local/bin:$PATH"
godot --path . --editor
```

## Tooling

- [GitHub Spec Kit](https://github.com/github/spec-kit) (`specify-cli` 0.16.3) — local library in `.specify/`
- Cursor skills in `.cursor/skills/` (Spec Kit, this game, plus vendored Godot 4 packs)
- GitHub remote: [bperussina/Aliens-vs.-Demons-](https://github.com/bperussina/Aliens-vs.-Demons-)

## Prerequisites

`uv`, Python 3.12 (via uv — not system Python 3.9), `specify`, `gh`, and **Godot 4.7.1** on `PATH` (`~/.local/bin`).

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
