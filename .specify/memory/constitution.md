<!--
Sync Impact Report
- Version change: 1.4.0 → 1.5.0 (You and the computer have health; 10 turns per match)
- Modified principles: template placeholders → I–V below
- Added sections: Art Direction, Technology Stack, Development Workflow
- Removed sections: none (template slots filled)
- Follow-up TODOs: none
-->

# Aliens vs. Demons Constitution

## Core Principles

### I. Spec Before Play
Every gameplay change MUST have a spec that says what the player sees and does
before code is written. Specs describe the game, not the engine. Plans describe
the stack and scenes. Unspecified behavior MUST NOT ship.

**Rationale**: Brody and Dad build in parallel. A written spec is the shared
picture of the game so neither side guesses.

### II. Illustrated Craft, Never Pixel
The game MUST look like a skilled illustrator's smooth drawings, not pixel art
and not scribbles. Textures MUST stay painterly and anti-aliased. Nearest-neighbor
pixel scaling, mosaic/pixelate filters, crayon/scribble fills, and "retro 8-bit"
styling are forbidden.

Characters MAY be made of craft materials (clay, cardboard, paper, skin-like
forms) but those materials MUST be drawn as finished illustration, not photos
of junk and not child-scribble placeholders.

**Rationale**: The look is a core part of the game, not a later coat of paint.

### III. Vampire Survivors Camera
The play camera MUST be a top-down action camera in the Vampire Survivors
family: the world is seen from above, the view follows the robot the player
controls, and the battlefield scrolls smoothly as the robot moves. The camera
MUST NOT be first-person, third-person over-the-shoulder, or locked isometric
tactics.

**Rationale**: Movement, swarms, and protecting the king all read clearly from
this angle.

### IV. Protect the King Computer
The king IS the computer. There is no extra machine sitting in the base.
The king MUST stay alive and MUST be click-moved. Demons hunt the king.
The robot and the king computer MUST have health. If either reaches zero, the
player loses. A match is 10 turns at a time.

Bullets MUST come out of the wire on the robot's head, in the direction that
wire is pointing. No extra computer sitting in the base.

The player starts with two turrets to place by clicking the map. After those
are down, clicking the map MUST NOT place more until the player buys extras.
A Shop control MUST sit next to the money. A turret costs $10. Unplaced turret
count MUST show next to the skills.

The game MUST open on a title menu. A match MUST NOT start until Single Player.
The King Demon MUST NOT enter the fight in this slice (chair cutscene only).

### V. Complete Slices
A slice MUST be playable, named clearly, on a branch, pushed to GitHub, and
opened as a pull request unless Brody or Dad says to wait. Feature work MUST
NOT land straight on `main`. Placeholder art MUST still obey Principle II
(smooth illustration, not pixels or scribbles).

**Rationale**: Dad reviews in parallel. Invisible or half-broken local work
cannot be reviewed.

## Art Direction

The king IS the computer: a finished illustrated royal desktop (monitor, tower,
keys, crown), not a second machine sitting next to a person.

Demons MUST read as people who have had robot eyes installed.

The robot is the player hero and MUST look like a finished illustrated robot,
not a stick figure or pixel sprite.

Match and menu art MUST use the painted sprites and textures in `assets/`.
Placeholder `_draw` geometry MUST NOT be the on-screen character.

Health bars sit above combatants so remaining health is readable at a glance
during a swarm.

## Technology Stack

The game MUST be built in **Godot 4** as a **2D** project using **GDScript**.

- 2D renderer with **linear** texture filtering (smooth). Pixel snap and
  nearest-neighbor filtering are forbidden except for debug overlays.
- Native `Camera2D` follow for the Vampire Survivors-style view.
- High-resolution illustrated sprites and textures (PNG/WebP with
  transparency), not tileset pixel atlases as the hero look.
- Export targets: desktop first (macOS / Windows). Web export is allowed later
  and MUST NOT drive art or control decisions.

This stack is the project default. Changing it requires a constitution
amendment, not a silent rewrite.

## Development Workflow

1. Constitution and specs live in this repo and are the source of truth.
2. Use Spec Kit skills in order: specify → clarify (if needed) → plan →
   tasks → implement.
3. Branch from latest `main` (`feat/`, `fix/`, `spec/`, `chore/`).
4. One concern per pull request. Dad reviews; do not merge your own feature
   PR unless asked.
5. Keep Spec Kit upgrades on their own chore branches.

## Governance

This constitution supersedes informal chat instructions when they conflict.
Amendments MUST update this file, bump the version (MAJOR for removed or
redefined principles, MINOR for new principles or stack changes, PATCH for
wording), and go through a pull request.

All PRs MUST be checked against Principles I–V and the Art Direction and
Technology Stack sections. Unjustified complexity MUST be rejected.

**Version**: 1.5.0 | **Ratified**: 2026-08-13 | **Last Amended**: 2026-08-13
