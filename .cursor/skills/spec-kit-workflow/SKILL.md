---
name: spec-kit-workflow
description: Orchestrates GitHub Spec Kit (specify-cli) Spec-Driven Development for this game. Use when starting features, writing specs, planning, implementing from tasks, updating constitution, or when the user mentions Spec Kit, specify, SDD, /speckit, or specs/.
---

# Spec Kit Workflow

This repo is Spec-Driven. Specs are source of truth. Do not implement gameplay, systems, or architecture until the matching spec artifacts exist.

Local Spec Kit library: `.specify/` (CLI v0.16.3, Cursor integration `cursor-agent`).

## Required order

1. **Constitution** — `/speckit-constitution` → `.specify/memory/constitution.md`
2. **Specify** — `/speckit-specify` → `specs/<NNN-name>/spec.md`
3. **Clarify** (optional, recommended) — `/speckit-clarify` before planning
4. **Plan** — `/speckit-plan` → `plan.md` plus design artifacts
5. **Tasks** — `/speckit-tasks` → `tasks.md`
6. **Analyze** (optional, recommended) — `/speckit-analyze` before coding
7. **Implement** — `/speckit-implement` against `tasks.md`
8. **Converge** — `/speckit-converge` when code drifts from spec/plan/tasks
9. **Issues** (optional) — `/speckit-taskstoissues` to mirror tasks on GitHub

Read the matching `.cursor/skills/speckit-*/SKILL.md` and follow it. Do not invent a parallel spec format.

## Agent rules

- Run commands from the repository root. Scripts live in `.specify/scripts/bash/`.
- Load `.specify/memory/constitution.md` before writing specs, plans, or code. If it is still a template (placeholders like `[PROJECT_NAME]`), run constitution first and stop.
- Focus specs on **what** and **why**. Put stack and architecture in the plan.
- Never skip `spec.md` + `plan.md` + `tasks.md` for a feature that changes behavior.
- After implementation, update task checkboxes. Use converge instead of silently expanding scope.
- Keep Spec Kit upgrades (`specify self upgrade`, `specify init --here --force`) separate from feature work.

## Artifacts

| Path | Role |
| --- | --- |
| `.specify/` | Installed Spec Kit templates, scripts, workflows |
| `.specify/memory/constitution.md` | Governing principles |
| `.specify/templates/` | Spec/plan/tasks templates |
| `specs/` | Feature specifications (created by specify) |
| `.cursor/skills/speckit-*/` | Official Spec Kit skills (do not rewrite) |

## CLI

```bash
specify check
specify self check
specify integration list
```

Upgrade the project files only when asked:

```bash
specify self upgrade
specify init --here --force --integration cursor-agent --script sh
```
