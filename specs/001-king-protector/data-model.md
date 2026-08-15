# Data Model: King Protector Arena

In-memory match objects. Nothing is saved between runs in this baseline.

## Robot

- `position`: world point (camera target)
- `facing`: last non-zero move direction
- `move_speed`: units per second (~280)
- Relationships: owned by Match; Camera2D follows this entity

## King

- `position`
- `health` / `max_health`
- `selected`: bool
- `move_target`: optional world point
- Look (non-negotiable): skin-blob head, two eyes, clay mouth, white cardboard box, hole with yellow paper
- Relationships: Match lose condition when `health == 0`

## Demon (not spawned in setup slice)

- `position`
- `kind`: Normal | Drifted | Deep Drift
- `health` / `max_health` (8 / 16 / 24 hits, plus a small Level bump)
- `target`: the King
- Look: person with installed robot eyes. Drifted and Deep Drift are further gone and hover.
- Coins: $10 / $20 / $35
- Health bar above body

## Turret

- `position`: world point chosen by a map click
- `preview`: ghost that follows the cursor while stock remains
- Auto-fires at the nearest demon in range
- Relationships: spawned by Match; consumes one unplaced turret from SaveData

## Shop

- Button next to coins
- Sells one turret for $10
- Relationships: SaveData coins and turret stock

## Arena

- Bounded rectangle the camera scrolls across
- Walkable interior; clicks outside clamp to nearest legal point (later)

## Match

- `state`: `playing` | `defeat` | `victory`
- Owns Robot, King, Demon list, wave index
- Setup slice: `playing` only (no waves yet)
