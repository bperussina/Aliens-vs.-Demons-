# Feature Specification: King Protector Arena

**Feature Branch**: `feat/illustrated-art`

**Created**: 2026-08-13

**Status**: Draft

**Input**: Title menu, then Single Player. The king IS the computer. Robot wire-gun plus two placeable turrets. After both are placed, map clicks do not plant more. Shop next to the money sells extra turrets for $10. Unplaced count sits next to skills. Waves, skills, $10 per kill, Wave 50 wins.

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

### User Story 6 - Place two turrets, then buy more (Priority: P1)

The player starts with two turrets. Click the map once to plant the first, click another place to plant the second. After that, clicking the map does not place a turret. Top-right, next to the money, a Shop button opens a shop. A turret costs $10. Next to the skills, the HUD shows how many unplaced turrets are left.

**Acceptance Scenarios**:

1. **Given** a fresh match, **When** the player looks next to the skills, **Then** it shows 2 turrets.
2. **Given** 2 unplaced turrets, **When** the player clicks two different map spots (king not selected), **Then** two turrets stand there and the count is 0.
3. **Given** 0 unplaced turrets, **When** the player clicks the map, **Then** no new turret appears.
4. **Given** at least $10, **When** the player clicks Shop then buys a turret, **Then** coins drop by $10 and the turret count goes up by 1 so they can click the map to place it.

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
- **FR-014**: The player MUST start with 2 unplaced turrets. A map click MUST place one when stock remains and the king is not selected.
- **FR-015**: Map clicks MUST NOT place a turret when stock is 0.
- **FR-016**: A Shop button MUST sit next to the money. Buying a turret MUST cost $10 and add 1 to unplaced stock.
- **FR-017**: Unplaced turret count MUST appear next to the skills.

## Key Entities

- **King** (the computer you protect), **Robot** (wire-gun), **Turret** (placed by the player), **Shop**, **Normal Demon**, **King Demon** (cutscene only), **Wave**, **Coins**, **Level**

## Success Criteria

- **SC-001**: First match view is Level + 10-second countdown, never an instant demon.
- **SC-002**: King Demon is only in the chair cutscene.
- **SC-003**: First spawn after the cutscene is a normal demon on Wave 1.
- **SC-004**: Eight wire-gun hits kill a normal demon; coins go up $10 and persist.
- **SC-005**: Wave 50 clear levels the player up.
- **SC-006**: Two map clicks plant the starting turrets; a third map click plants nothing until a $10 shop buy.

## Assumptions

- Wave N spawns `min(N, 10)` normal demons.
- Skills target nearby demons and have cooldowns.
- Characters and the battlefield use painted sprites in `assets/sprites` and `assets/textures`.
- Save file stores coins, level, and unplaced turret stock on disk. New saves start with 2 turrets.
- Placed turrets auto-fire at nearby demons. The robot wire-gun still fires the way the wire points.
- Live online multiplayer is still later; unlock only reveals that tools are coming.
