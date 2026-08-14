---
name: dev-philosophy
description: Development philosophy for Aliens vs. Demons — infer full intent, ship complete high-quality work, and use strict branch/PR/merge discipline so Brody and Dad can code in parallel. Use when starting work, branching, committing, pushing, opening PRs, merging, or interpreting a vague request.
---

# Development Philosophy

Brody is eight years old and has no idea how to build programs or games. He is parallel coding with his dad, and his dad knows how to code. When taking orders from Brody, read between the lines and do not take them in an ambiguous way. Deliver a superior product every single time with not a lot of technical oversight.

## Read between the lines

Brody will say the destination, not the map.

- Infer the complete feature, not the smallest thing that matches the words.
- If a request is vague, choose the strongest fun, clear, shippable interpretation and execute it.
- Do the git, spec, tests, polish, and GitHub steps he did not know to name.
- Ask a question only when two interpretations would produce a different game. Otherwise decide and go.
- Never talk down. Explain in plain language when useful; keep the code at Dad-review quality.

## Quality bar

- Specs before gameplay code. Follow `spec-kit-workflow`.
- Finish the unit of work: it runs, it is named clearly, it is on GitHub, Dad can review it.
- Do not leave TODOs, broken states, or "you can fill this in later" as the delivery.
- Prefer a smaller complete slice over a large half-built one.

## Branching and merging

Dad and Brody work in parallel. `main` is the shared good game. Feature work never lands straight on `main`.

1. Start from latest `main`: `git fetch origin && git checkout main && git pull`.
2. Create a branch named for the work:
   - `feat/<short-name>` gameplay or systems
   - `fix/<short-name>` bugs
   - `spec/<short-name>` spec-only
   - `chore/<short-name>` tooling, skills, repo setup
3. Call `SetActiveBranch` so the session tracks that branch.
4. Do the work on that branch only.
5. When the slice is done: commit, `git push -u origin HEAD`, open a PR into `main`.
6. Do not merge your own PR unless Brody or Dad asks. Parallel coding means Dad should be able to review.

### PR shape

- One concern per branch. Do not mix unrelated features.
- Title says why. Body has summary + how to try it.
- Push regularly so Dad can see progress before the PR is "perfect."
- Never force-push `main`. Never rewrite shared history unless Dad asks.

### Example

Request: "add jumping"

- Branch `feat/player-jump` off latest `main`
- Spec if behavior is new (`/speckit-specify` and the rest of the loop)
- Implement jump that feels good, with clear controls and no broken movement
- Commit, push, open PR for Dad

Not: edit files on `main`, wait to be told to commit, or ship an invisible local-only change.

## GitHub

Use `github-cli`. Repo: `bperussina/Aliens-vs.-Demons-`. After a finished slice, the branch must exist on GitHub with a PR unless Brody explicitly says to wait.
