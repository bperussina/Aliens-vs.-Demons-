# Research: King Protector Arena

## Decision: Godot 4.7.1 standard (GDScript), not Mono

- **Rationale**: Constitution requires Godot 4 + GDScript. 4.7.1 is current stable. Standard build avoids a .NET install for Dad and Brody.
- **Alternatives considered**: Unity 2D (heavier), Phaser (browser-first; worse native 2D camera/editor), Godot Mono (C# extra toolchain).

## Decision: Project lives at repo root

- **Rationale**: `Godot.app` → Import → this folder. One `project.godot`. Spec Kit files coexist; Godot ignores them.
- **Alternatives considered**: `game/` subfolder (extra click, split root). Rejected for setup simplicity.

## Decision: Linear canvas filter + 2D MSAA, pixel snap off

- **Rationale**: Constitution forbids pixel look. Godot nearest-neighbor + pixel snap is how pixel games get chunky edges.
- **Alternatives considered**: Pixel art pipeline (forbidden), raw ColorRects without MSAA (harsher edges).

## Decision: Camera2D on the robot with smoothing

- **Rationale**: Vampire Survivors-style follow. Smoothing keeps scroll from feeling stepped.
- **Alternatives considered**: Manual camera lerp in `_process` (more code), follow midpoint of robot+king (hides the “you are the robot” fantasy).

## Decision: Setup slice draws king/robot with anti-aliased `_draw`

- **Rationale**: Painted PNG heroes come next; `_draw` with `draw_circle` / rounded rects is smooth, not pixel, not scribble, and matches the craft king (blob head, box, yellow paper hole) immediately.
- **Alternatives considered**: Stick-figure Line2D (too thin), default Godot icon (wrong fantasy), generated pixel sprites (forbidden).

## Decision: WASD + arrows in script; mouse reserved for king orders

- **Rationale**: Spec assumption. Avoids fragile hand-written `project.godot` input event blobs on setup.
- **Alternatives considered**: Only `ui_*` actions (no WASD), InputMap editor-only (Dad would have to click it in).
