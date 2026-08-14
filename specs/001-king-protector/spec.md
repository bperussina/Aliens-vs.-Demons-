# Feature Specification: King Protector Arena

**Feature Branch**: `feat/waves-combat-skills`

**Created**: 2026-08-13

**Status**: Draft

**Input**: Title menu, then Single Player: Level at the top, 10-second combat countdown, King Demon cutscene (chair only). The king IS the computer (no extra PC in the base). Bullets auto-fire out of the wire on the robot's head, in the direction the wire points. Normal demons have four-quarter health; each bullet is half a quarter. Number-key skills. $10 per kill, saved. Wave 50 wins the round.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Title menu first (Priority: P1)

Launch is the green menu. No king, no King Demon, no normal demons until Single Player.

### User Story 2 - Level, countdown, then cutscene, then a normal demon (Priority: P1)

Single Player shows Level at the top (start at Level 1) and "Combat starting in 10 seconds". At zero, a cutscene shows the King Demon in a chair sending normal demons. He does not appear on the field. Then Wave 1 starts and a normal demon spawns.

**Acceptance Scenarios**:

1. **Given** Single Player just started, **When** the player looks at the top of the screen, **Then** it shows Level and a 10-second combat countdown.
2. **Given** the countdown hits zero, **When** the next moment plays, **Then** a cutscene of the King Demon in a chair plays, and he is not walking the arena.
3. **Given** the cutscene ends, **When** combat begins, **Then** the HUD shows the wave number and a normal demon (person with robot eyes) spawns. The King Demon is still not in the fight.

### User Story 3 - Waves, wire-gun, and skills (Priority: P1)

Normal demons have four quarters of health. Bullets automatically come out of the wire on the robot's head, in the direction that wire is pointing. Each bullet does half of one quarter (eight hits to kill). Number keys 1–8 fire skills. Killing a normal demon grants $10 that is saved.

**Acceptance Scenarios**:

1. **Given** a normal demon, **When** the robot's head-wire fires, **Then** bullets leave the tip of the wire in the wire's direction and each hit knocks half a quarter off the four-quarter bar (eight hits to kill).
2. **Given** a dead normal demon, **When** the player checks coins, **Then** they gained $10 and it is still there after leaving and returning.
3. **Given** combat, **When** the player presses 1–8, **Then** a skill fires (fire, magic, acid, frost, spark, void, gum, quake).
4. **Given** a wave is cleared, **When** more waves remain, **Then** the next wave number shows and more demons spawn.

### User Story 4 - Wave 50 wins the round and levels up (Priority: P1)

Clearing wave 50 wins the round and the player gains a level. Multiplayer level-making stays locked until Level 50 and $1000.

### User Story 5 - The king is the computer (Priority: P1)

There is no extra computer sitting in the base. The king is the computer. Click-move the king. Demons hunt the king. Esc returns to the menu.

## Requirements *(mandatory)*

- **FR-001**: Launch MUST be the green title menu.
- **FR-002**: Match HUD MUST show Level and then a 10-second combat countdown at the top.
- **FR-003**: After countdown, a King Demon chair cutscene MUST play. The King Demon MUST NOT spawn as a fighter in this slice.
- **FR-004**: After the cutscene, Wave 1 MUST start and spawn a normal demon.
- **FR-005**: HUD MUST show the current wave after the countdown.
- **FR-006**: Normal demons MUST have four visible health quarters. A wire-bullet MUST deal half of one quarter (8 hits to kill).
- **FR-007**: Bullets MUST spawn at the robot head-wire tip and travel the way the wire points. There MUST NOT be a separate PC turret.
- **FR-013**: Click-move the king computer, robot WASD aims the wire, no extra PC in the base, no pixel art.
- **FR-008**: Keys 1–8 MUST cast fire, magic, acid, frost, spark, void, gum, and quake skills.
- **FR-009**: Killing a normal demon MUST add $10 to saved coins.
- **FR-010**: Clearing a wave MUST start the next wave until wave 50.
- **FR-011**: Clearing wave 50 MUST win the round and increase Level by 1.
- **FR-012**: Multiplayer level-making MUST stay locked until Level 50 and $1000.

## Key Entities

- **King** (the computer you protect), **Robot** (wire-gun), **Normal Demon**, **King Demon** (cutscene only), **Wave**, **Coins**, **Level**

## Success Criteria

- **SC-001**: First match view is Level + 10-second countdown, never an instant demon.
- **SC-002**: King Demon is only in the chair cutscene.
- **SC-003**: First spawn after the cutscene is a normal demon on Wave 1.
- **SC-004**: Eight wire-gun hits kill a normal demon; coins go up $10 and persist.
- **SC-005**: Wave 50 clear levels the player up.

## Assumptions

- Wave N spawns `min(N, 10)` normal demons.
- Skills target nearby demons and have cooldowns.
- Save file stores coins and level on disk.
- Live online multiplayer is still later; unlock only reveals that tools are coming.
