---
name: godot-skills-index
description: Router for the vendored Godot 4 skill packs in this repo. Use when starting Godot work, unsure which skill to read, or when a generic Godot skill might conflict with this 2D illustrated game.
---

# Godot Skills Index

This repo vendors two Godot 4 skill libraries under `.cursor/skills/`:

- **GD Agentic Skills** (LGPL-3.0) — `godot-*` names. Upstream: [thedivergentai/gd-agentic-skills](https://github.com/thedivergentai/gd-agentic-skills). License: `third_party/gd-agentic-skills/LICENSE`.
- **GodotPrompter** (MIT) — names like `gdscript-patterns`, `camera-system`, `2d-essentials`. Upstream: [jame581/GodotPrompter](https://github.com/jame581/GodotPrompter). License: `third_party/GodotPrompter/LICENSE`.

Plus this project's own `godot-project` skill (open/run this game).

## This game wins

Aliens vs. Demons is **Godot 4.7.1, 2D, GDScript only**, Vampire Survivors camera, smooth illustrated art (never pixel). Constitution in `.specify/memory/constitution.md` beats any skill that says 3D, C#, Mono, pixel snap, or nearest-neighbor.

Ignore or do not apply: `csharp-godot`, `csharp-signals`, `xr-development`, `3d-essentials`, `godot-3d-*`, `godot-physics-3d`, `godot-platform-vr`, pixel-art pipelines.

## Read first for this project

| Need | Skill |
| --- | --- |
| Open / Play this repo | `godot-project` |
| GDScript style | `gdscript-patterns`, `godot-gdscript-mastery` |
| Robot move | `godot-characterbody-2d`, `player-controller`, `godot-input-handling` |
| Camera follow | `camera-system`, `godot-camera-systems` |
| Click king / areas | `godot-2d-physics`, `input-handling` |
| Combat / waves | `godot-combat-system`, `godot-game-loop-waves` |
| Health bars / HUD | `hud-system`, `godot-ui-containers` |
| Scenes | `scene-organization`, `godot-scene-management` |
| Art import | `assets-pipeline` |
| Debug | `godot-debugging`, `godot-debugging-profiling` |

Orchestrator if the task is large: `godot-master` (then the specific 2D skill). Do not let `godot-master` switch the stack.
