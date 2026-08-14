# Feature Specification: King Protector Arena

**Feature Branch**: `spec/001-king-protector`

**Created**: 2026-08-13

**Status**: Draft

**Input**: User description: "Camera like Vampire Survivors. Demons look like people with robot eyes. King is a big skin-blob head with two eyes and a clay mouth, on a white cardboard box with a hole showing yellow paper. Player is the robot and must protect the king. King has health. Click the king, click the map to move him, click the king again to deselect. Robot fights demons. Health bars above demons. Smooth illustrated look, not pixel art, not scribbles."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Play as the robot on a scrolling battlefield (Priority: P1)

The player starts a match as the robot. The camera looks down on the field the way Vampire Survivors does: the world is seen from above, and the view follows the robot as it moves. The player steers the robot around the arena and immediately understands they are the fighter.

**Why this priority**: Without a controllable robot and this camera, there is no game to show.

**Independent Test**: Launch a match, move the robot in all directions, and confirm the camera stays on the robot while the ground slides underneath.

**Acceptance Scenarios**:

1. **Given** a new match, **When** the player uses the movement controls, **Then** the robot walks in that direction at a steady, readable speed.
2. **Given** the robot is moving, **When** the robot reaches the edge of the visible view, **Then** the camera scrolls with the robot instead of letting the robot disappear.
3. **Given** the robot is standing still, **When** the player is not touching movement, **Then** the robot idles facing its last direction and the camera stays centered on it.

---

### User Story 2 - Protect the king (Priority: P1)

The king stands on the field as the thing that must survive. He has health. If that health reaches zero, the match ends as a loss. The king looks like this: a large blob of skin for a head, two eyes, a piece of clay for a mouth, and below the head a big white cardboard box with a hole poked through it that shows yellow paper.

**Why this priority**: Protecting this specific king is the point of Aliens vs. Demons.

**Independent Test**: Start a match, find the king by silhouette alone, watch his health, and confirm the match ends when his health hits zero.

**Acceptance Scenarios**:

1. **Given** a new match, **When** the player looks at the field, **Then** the king is visible and matches the skin-blob head, clay mouth, and cardboard-box body with yellow paper in the hole.
2. **Given** the king is alive, **When** something damages the king, **Then** his health goes down and remaining health stays readable.
3. **Given** the king's health is greater than zero, **When** health reaches zero, **Then** the match ends as a defeat and the player can start again.

---

### User Story 3 - Click the king to move him (Priority: P1)

The player can order the king to walk somewhere without taking control away from the robot. Click the king to select him, click a spot on the map to send him there, click the king again to deselect. While selected, the king is obviously chosen. While not selected, clicks on the map do not move him.

**Why this priority**: This is the exact control scheme requested; the king is a companion you command, not a second character you possess.

**Independent Test**: Select the king, click a far spot, watch him walk there, click him again, then click the map and confirm he stays put.

**Acceptance Scenarios**:

1. **Given** the king is not selected, **When** the player clicks the king, **Then** the king becomes selected and shows a clear selected look.
2. **Given** the king is selected, **When** the player clicks a walkable spot on the map, **Then** the king walks to that spot while the player can still move the robot.
3. **Given** the king is selected, **When** the player clicks the king again, **Then** the king is no longer selected and further map clicks do not move him.
4. **Given** the king is not selected, **When** the player clicks the map, **Then** the king does not move.

---

### User Story 4 - Fight demons with visible health (Priority: P1)

Demons look like people who have had robot eyes installed. They come after the king. The robot fights them. Each demon shows a health bar above its body. When a demon's health reaches zero, that demon is gone.

**Why this priority**: Combat against this enemy look, with readable health, is the action fantasy.

**Independent Test**: Let demons appear, confirm they look like people with robot eyes, confirm health bars sit above them, and confirm the robot can defeat them.

**Acceptance Scenarios**:

1. **Given** a match is running, **When** demons are on the field, **Then** each one reads as a person with installed robot eyes, not a generic blob.
2. **Given** a demon is alive, **When** the player looks at it, **Then** a health bar is visible above it and shrinks when the demon takes damage.
3. **Given** the robot is near a demon, **When** the robot fights, **Then** the demon loses health.
4. **Given** a demon's health reaches zero, **When** that happens, **Then** that demon disappears from the fight.

---

### User Story 5 - Smooth illustrated look (Priority: P1)

The whole match looks like finished drawing, not pixels and not scribbles. Edges are smooth. The king, robot, demons, and ground look like someone who draws very well painted them. The camera motion is smooth, not chunky or grid-snapped.

**Why this priority**: The look was called out as non-negotiable.

**Independent Test**: Watch a match in motion and reject it if characters look pixel-blocky, crayon-scribbled, or jagged when they move and the camera scrolls.

**Acceptance Scenarios**:

1. **Given** any character or the ground, **When** viewed during play, **Then** it looks like smooth illustration, not pixel art.
2. **Given** the camera is scrolling, **When** sprites move across the screen, **Then** they stay sharp and smooth, not blocky or shimmering into pixels.

---

### Edge Cases

- If the player clicks the king while he is already walking, selection stays on and a new map click replaces the old destination.
- If the player clicks a blocked or off-arena spot, the king does not walk through walls; he goes to the nearest legal point or stays, with no freeze.
- If the king is selected and a demon is clicked, that click does not count as a move order; selection stays until a map click or a deselect click on the king.
- If the robot and king overlap, both stay clickable; a click on the king prefers selecting the king.
- If no demons are alive, the field stays calm until the next group arrives or the match is won.
- If the robot is far from the king, the camera still follows the robot; the king may leave the screen, and a small marker or the king's health display still tells the player the king is in danger.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The player MUST control the robot directly with movement input for the whole match.
- **FR-002**: The camera MUST be a top-down Vampire Survivors-style view that follows the robot and scrolls the battlefield smoothly.
- **FR-003**: The king MUST appear as a large skin-blob head with two eyes and a clay mouth, on a white cardboard box with a hole that shows yellow paper.
- **FR-004**: The king MUST have health. When it reaches zero, the match MUST end as a loss.
- **FR-005**: Clicking the unselected king MUST select him. Clicking the selected king MUST deselect him.
- **FR-006**: While the king is selected, clicking a walkable point on the map MUST send the king walking there. The robot MUST remain under player control during that walk.
- **FR-007**: While the king is not selected, map clicks MUST NOT move the king.
- **FR-008**: Demons MUST look like people with robot eyes installed.
- **FR-009**: Demons MUST threaten the king (they move toward him and can damage him).
- **FR-010**: The robot MUST be able to fight and defeat demons.
- **FR-011**: Each living demon MUST show a health bar above it that reflects remaining health.
- **FR-012**: The king's remaining health MUST stay visible during the match.
- **FR-013**: Visuals MUST be smooth illustration. Pixel-art presentation and scribble/crayon presentation are forbidden.
- **FR-014**: A match MUST have a clear start, a playing state, and a defeat state when the king falls. A simple victory after surviving the baseline wave set MUST exist so a full loop can be finished.

### Key Entities

- **Robot**: Player-controlled fighter. Moves with direct input. Attacks demons. Camera target.
- **King**: Escort/objective. Unique look (skin-blob head, clay mouth, cardboard box, yellow paper). Has health. Click-to-select, click-map-to-move, click-again-to-deselect.
- **Demon**: Enemy. Person with robot eyes. Has health. Health bar above body. Damages the king; can be defeated by the robot.
- **Arena**: Bounded battlefield the camera scrolls across.
- **Match**: One play session with start, fight, victory (waves cleared) or defeat (king health zero).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A new player can move the robot and see the camera follow within 10 seconds of match start, without instructions beyond on-screen prompts.
- **SC-002**: A new player can select the king, send him to a clicked spot, and deselect him on the first try using only click-king / click-map / click-king.
- **SC-003**: During a fight with at least three demons on screen, every demon's health bar is readable without pausing.
- **SC-004**: 100% of reviewers shown a still frame can describe the king as a skin-blob head on a cardboard box with yellow paper in a hole, and demons as people with robot eyes.
- **SC-005**: 100% of reviewers shown motion reject the build if it looks pixelated or scribbled.
- **SC-006**: When the king's health hits zero, the player sees a defeat result in under 2 seconds and can start a new match without restarting the app.

## Assumptions

- Robot movement uses keyboard or stick directions (standard action-game move). Mouse is for king orders.
- Robot combat is automatic when demons are in range, in the Vampire Survivors family, so the player can steer and still fight.
- Demons prefer the king as their target so the protection fantasy is real; they do not ignore the king to only chase the robot.
- Baseline match is a short set of demon waves on one arena, not an endless run and not a campaign of maps.
- King health is also shown (bar or equivalent) because he is the lose condition; demon bars were requested explicitly and the king needs the same clarity.
- Clicking a demon while the king is selected does not issue a move; only empty ground / map issues a move.
- No pixel-art "for performance." Smooth illustrated sprites at playable framerate is required.
- Audio, upgrades, shops, and multiple king skins are out of scope for this baseline.
