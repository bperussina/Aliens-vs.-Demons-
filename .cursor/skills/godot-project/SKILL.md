---
name: godot-project
description: How to open, run, and extend the Aliens vs. Demons Godot 4.7.1 2D project. Use when editing scenes, GDScript, project.godot, art import, camera, or when the user mentions Godot, Play, F5, or the editor.
---

# Godot Project

Engine: **Godot 4.7.1** standard (GDScript, not Mono). App: `/Applications/Godot.app`. CLI: `godot` on `PATH` via `~/.local/bin/godot`.

Open **this repository folder**. `project.godot` is at the root.

```bash
export PATH="$HOME/.local/bin:$PATH"
godot --version          # 4.7.1.stable...
godot --path . --editor
godot --headless --path . --quit
```

## Must keep

- 2D only. Linear texture filter (`default_texture_filter=1`). Pixel snap **off**. 2D MSAA on.
- Camera follows the robot (`Camera2D` child of `Robot`).
- Placeholders and sprites stay smooth illustration — no nearest-neighbor hero art.
- Main scene: `scenes/main_menu.tscn` (title). Match: `scenes/main.tscn`.

## Layout

| Path | Role |
| --- | --- |
| `project.godot` | Project settings |
| `scenes/main.tscn` | Match: arena, king, robot, camera |
| `scripts/*.gd` | GDScript |
| `.godot/` | Generated — do not commit |

## After script/scene edits

Let Godot import once (`godot --headless --path . --import` or open the editor) before assuming UIDs/import files are final.

## Skill packs

This repo vendors 150+ Godot 4 skills (GD Agentic Skills + GodotPrompter). Start at `godot-skills-index`. Never let a 3D/C#/pixel skill override this 2D GDScript project.
