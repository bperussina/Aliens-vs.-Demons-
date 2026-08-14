# Feature Specification: King Protector Arena

**Feature Branch**: `feat/title-menu-and-pc`

**Created**: 2026-08-13

**Status**: Draft

**Input**: User description: "Don't show the king or demons on login. Green background with multiplayer, single player, settings. In the game: a PC in the middle to protect. The king protects the PC the most, so keep the king alive. Click-move the king like before."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Title menu on launch (Priority: P1)

When the game opens, the player is not in a fight. They see a basic green screen with the game name and buttons: Single Player, Multiplayer, Settings. Nothing starts until they pick one.

**Why this priority**: This is the login/home they asked to see first.

**Independent Test**: Launch the app and confirm the first frame is the green menu, with no king, no demons, and no arena yet.

**Acceptance Scenarios**:

1. **Given** the app just opened, **When** the player looks at the window, **Then** they see a green background and the title Aliens vs. Demons.
2. **Given** the title menu, **When** the player looks at the buttons, **Then** Single Player, Multiplayer, and Settings are all visible and clickable.
3. **Given** the title menu, **When** the player has not pressed Single Player, **Then** no match, king, PC, or demons are shown.

---

### User Story 2 - Single Player enters the PC match (Priority: P1)

Single Player loads the match: a PC sits in the middle of the field. The king stands near it. The player is the robot. There are no demons in this slice.

**Why this priority**: This is the game they want after the menu.

**Independent Test**: Click Single Player and find a computer in the center and the cardboard-box king nearby, with no enemies.

**Acceptance Scenarios**:

1. **Given** the title menu, **When** the player clicks Single Player, **Then** the match loads with a PC in the middle of the field.
2. **Given** the match, **When** the player looks around the PC, **Then** the king is there (skin-blob head, clay mouth, white box, yellow paper in the hole).
3. **Given** the match, **When** the player looks for enemies, **Then** no demons are present.

---

### User Story 3 - Move the king to guard the PC (Priority: P1)

The king is the main protector of the PC. The player click-selects the king, clicks the map to walk him, clicks the king again to deselect. The robot still walks with the keyboard.

**Why this priority**: Same king control as before; now the job is guarding the PC.

**Independent Test**: Select the king, send him around the PC, deselect, click the ground, confirm he stays.

**Acceptance Scenarios**:

1. **Given** the king is not selected, **When** the player clicks the king, **Then** the king shows a selected look.
2. **Given** the king is selected, **When** the player clicks a spot on the map, **Then** the king walks there while the robot can still move.
3. **Given** the king is selected, **When** the player clicks the king again, **Then** he is deslected and map clicks do not move him.
4. **Given** the king is not selected, **When** the player clicks the map, **Then** the king does not move.

---

### User Story 4 - Multiplayer and Settings from the menu (Priority: P1)

Multiplayer and Settings are real menu choices. Settings can be opened and closed. Multiplayer is a real screen that says it is not ready yet and lets the player go back. The player can return to the title menu from a match with Escape.

**Why this priority**: They asked for those buttons on login, not a dead layout.

**Independent Test**: Open Settings and go back. Open Multiplayer and go back. Enter Single Player and press Escape back to the green menu.

**Acceptance Scenarios**:

1. **Given** the title menu, **When** the player clicks Settings, **Then** a settings screen opens, and Back returns to the title menu.
2. **Given** the title menu, **When** the player clicks Multiplayer, **Then** they see a multiplayer screen they can leave with Back, and a match does not start.
3. **Given** a Single Player match, **When** the player presses Escape, **Then** they return to the green title menu.

---

### User Story 5 - Smooth illustrated look (Priority: P1)

Menu and match look like finished drawing, not pixels and not scribbles.

**Why this priority**: Non-negotiable art rule.

**Independent Test**: Reject the build if the green menu, PC, king, or robot look pixel-blocky or scribbled.

**Acceptance Scenarios**:

1. **Given** the title menu or the match, **When** viewed in motion, **Then** edges stay smooth.

---

### Edge Cases

- Clicking the king while he is walking keeps him selected; a new map click replaces the destination.
- Clicking the king to deselect does not also issue a walk order.
- A click on the PC while the king is selected counts as a map walk toward that point.
- Escape from Settings or Multiplayer returns to the title menu, not into a match.
- Demons, king health-loss, and waves are out of this slice.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Launch MUST show the title menu, not a match.
- **FR-002**: Title menu MUST use a green background and offer Single Player, Multiplayer, and Settings.
- **FR-003**: Single Player MUST load a match with a PC in the middle of the field.
- **FR-004**: The king MUST appear in the match with the specified look and MUST be the main protector of the PC.
- **FR-005**: Clicking the unselected king MUST select him. Clicking the selected king MUST deselect him.
- **FR-006**: While the king is selected, clicking the map MUST send him walking there. The robot MUST remain controllable.
- **FR-007**: While the king is not selected, map clicks MUST NOT move the king.
- **FR-008**: This slice MUST NOT spawn demons.
- **FR-009**: The player MUST control the robot with movement input during a match. The camera MUST follow the robot (Vampire Survivors-style).
- **FR-010**: Multiplayer MUST be a reachable menu screen that does not start a match.
- **FR-011**: Settings MUST be a reachable screen with a way back to the title menu.
- **FR-012**: Escape during a match MUST return to the title menu.
- **FR-013**: Visuals MUST be smooth illustration. Pixel-art and scribble looks are forbidden.

### Key Entities

- **Title Menu**: First screen. Green. Mode buttons.
- **PC**: Computer in the center of the match. The thing being protected.
- **King**: Main protector of the PC. Click-to-move. Specified look.
- **Robot**: Player body. Direct move. Camera target.
- **Arena**: Field around the PC.
- **Match**: Single Player session. No demons in this slice.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A new player sees the green title menu on first launch, before any match, every time.
- **SC-002**: From the menu, Single Player puts a PC in the middle of the field within 3 seconds.
- **SC-003**: A new player can select the king, walk him, and deselect on the first try.
- **SC-004**: Multiplayer and Settings are each reachable in one click from the title menu and can return in one click.
- **SC-005**: Reviewers reject the build if it looks pixelated or scribbled, or if demons appear in this slice.

## Assumptions

- "Log in" means the title/home screen, not an account system.
- Multiplayer is a menu entry now; live online play comes later.
- Settings can be simple (back, plus at least one real control such as fullscreen).
- Robot WASD/arrows still apply in the match.
- Demons, health-loss defeat, and waves stay specified for later slices, not this one.
- No pixel art.
