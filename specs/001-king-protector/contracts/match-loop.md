# Contract: Match Loop (player-facing)

This is the play contract for the baseline match. Setup implements start + robot move + camera + visible king. Later tasks fill combat and king orders.

## Start

- Player presses Play in Godot (or runs `godot --path .`).
- Match opens in `playing`.
- Robot, king, and arena are visible. Camera is on the robot.

## Playing

- WASD / arrow keys move the robot. Camera follows smoothly.
- King stands on the field with the specified look.
- Later: click king to select, click map to walk, click king to deselect.
- Later: demons hunt the king; robot auto-attacks in range; health bars show.

## Defeat

- Later: king health reaches 0 → defeat screen within 2 seconds → restart match without quitting the app.

## Victory

- Later: baseline wave set cleared → victory → restart.

## Non-goals (this contract version)

- Upgrades, shops, audio, multiple maps, pixel art modes.
