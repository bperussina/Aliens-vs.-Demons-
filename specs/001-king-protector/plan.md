# Implementation Plan: King Protector Arena

**Branch**: `feat/godot-setup` | **Date**: 2026-08-13 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/001-king-protector/spec.md`

## Summary

Aliens vs. Demons is a top-down protector match: the player steers a robot, click-commands the cardboard-box king, and fights robot-eyed demons. Build it as a **Godot 4.7.1 2D** project at the repo root, with linear texture filtering, `Camera2D` follow, GDScript scenes, and high-resolution illustrated (not pixel) art.

This slice sets up the engine, project, and a runnable main scene (arena + robot + king + following camera). Combat, waves, and click-to-move land in follow-up implementation tasks.

## Technical Context

**Language/Version**: GDScript on Godot 4.7.1 (standard build, not Mono/C#)

**Primary Dependencies**: Godot 4.7.1 engine only (no addons for baseline)

**Storage**: None (match state is in-memory)

**Testing**: Godot GUT later if needed; baseline validation is Play + `quickstart.md` checks

**Target Platform**: macOS desktop first (this machine); Windows export later

**Project Type**: 2D desktop game

**Performance Goals**: 60 fps at 1920×1080 with a short demon wave (dozens of sprites)

**Constraints**: Linear filtering; no pixel snap; 2D MSAA on; no nearest-neighbor hero art

**Scale/Scope**: One arena, one king, one robot, short wave set; no campaign/meta

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **I. Spec Before Play**: PASS — spec exists; this plan does not invent unspecified modes.
- **II. Illustrated Craft, Never Pixel**: PASS — project defaults linear filter, MSAA 2D, no pixel snap; placeholders use anti-aliased `_draw`, not pixel tiles.
- **III. Vampire Survivors Camera**: PASS — `Camera2D` child of the robot with position smoothing.
- **IV. Protect the King**: PASS — king is in the main scene as the objective; combat/waves come next without changing that fantasy.
- **V. Complete Slices**: PASS — Godot setup ships as its own branch/PR with a scene you can Play.

Post-design re-check: PASS. No new stack. No pixel pipeline.

## Project Structure

### Documentation (this feature)

```text
specs/001-king-protector/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── match-loop.md
└── spec.md
```

### Source Code (repository root)

```text
project.godot
icon.svg
scenes/
├── main.tscn
scripts/
├── match.gd
├── arena.gd
├── robot.gd
└── king.gd
assets/                 # painted sprites later; empty on setup
```

**Structure Decision**: Single Godot project at the repository root so opening this folder in Godot is the whole game. Spec Kit stays beside it (`.specify/`, `specs/`). Generated `.godot/` is gitignored.

## Complexity Tracking

> No constitution violations.
