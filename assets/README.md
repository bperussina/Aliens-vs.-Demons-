# Game art

Painted illustrations for Aliens vs. Demons. Smooth anti-aliased sprites, not pixel art.

| Path | Use |
| --- | --- |
| `sprites/robot.png` | Player robot (yellow head-wire is the gun) |
| `sprites/king.png` | King computer |
| `sprites/demon.png` | Normal demon |
| `sprites/king_demon.png` | King Demon cutscene |
| `sprites/turret.png` | Placeable turret |
| `sprites/bullet.png` | Shot glow |
| `textures/grass.png` | Arena field |
| `textures/plaza.png` | Dirt plaza under the king |
| `textures/title_bg.png` | Title / settings / multiplayer backdrop |

Regenerate character cutouts with:

```bash
export PATH="$HOME/.local/bin:$PATH"
uv run --python 3.12 --with pillow --with numpy python tools/prepare_sprites.py
```
