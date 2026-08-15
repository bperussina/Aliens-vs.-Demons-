# Quickstart: Godot setup

## Prerequisites

- macOS
- Godot **4.7.1** at `/Applications/Godot.app`
- CLI on PATH: `export PATH="$HOME/.local/bin:$PATH"` then `godot --version` → `4.7.1`

If Godot is missing:

1. Download [Godot 4.7.1 macOS universal](https://github.com/godotengine/godot-builds/releases/download/4.7.1-stable/Godot_v4.7.1-stable_macos.universal.zip)
2. Unzip and move `Godot.app` into `/Applications`
3. `ln -sfn /Applications/Godot.app/Contents/MacOS/Godot ~/.local/bin/godot`

## Open the game

1. Open **Godot 4.7.1**
2. Import / Open this repository folder (`Aliens-vs.-Demons-`)
3. Confirm it sees `project.godot`
4. Press **Play** (F5)

Or from the repo root:

```bash
export PATH="$HOME/.local/bin:$PATH"
godot --path . --editor
```

Headless import check:

```bash
godot --headless --path . --quit
```

## What you should see

- A wide painted-looking field (not a pixel grid)
- The king: skin-blob head, clay mouth, white box, yellow paper in a hole
- The robot nearby
- WASD or arrows move the robot; the camera slides with him
- Walking characters bounce with a step; they do not slide like stickers

## Fail if

- Characters look blocky/pixelated
- The robot, king, or demons ice-skate without a walk bounce
- Camera does not follow the robot
- Godot asks to convert from an older version (wrong engine)
