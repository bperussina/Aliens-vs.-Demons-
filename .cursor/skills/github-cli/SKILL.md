---
name: github-cli
description: GitHub CLI (gh) and git workflow for this repository. Use when connecting remotes, creating PRs/issues, checking CI, authenticating, listing runs, or converting Spec Kit tasks to GitHub issues.
---

# GitHub CLI

Remote: `https://github.com/bperussina/Aliens-vs.-Demons-.git` (`origin`)
Repo: `bperussina/Aliens-vs.-Demons-`
Default branch: `main`

Use `gh` for all GitHub API work (issues, PRs, checks, releases). Do not curl the GitHub API unless `gh` cannot do it.

## Auth

```bash
gh auth status
```

If the token is invalid or GraphQL returns Forbidden:

```bash
gh auth refresh -h github.com
```

That command is interactive. Stop and ask the user to complete login; do not invent tokens.

Git HTTPS uses `osxkeychain`. Confirm the remote before any write:

```bash
git remote -v
git config --get remote.origin.url
```

## Common commands

```bash
gh repo view
gh issue list
gh issue create --title "..." --body "..."
gh pr list
gh pr view
gh pr checks
gh run list
gh run view <id>
```

Create PRs with `gh pr create` after pushing the branch. Follow the repo's pull-request conventions: summary + test plan, HEREDOC body, no force-push to `main`.

## Git safety

- Commit only when the user asks.
- Never `git config`, `--no-verify`, or force-push `main`/`master`.
- Never skip hooks unless the user explicitly asks.
- Push with `git push -u origin HEAD` when a branch needs a remote.

## Spec Kit issues

When the user wants tasks on GitHub, use `/speckit-taskstoissues` (see `.cursor/skills/speckit-taskstoissues/SKILL.md`).

- Only create issues in `bperussina/Aliens-vs.-Demons-`.
- Deduplicate by task id (`T001`, `T002`, …) in existing issue titles.
- Title format: `T001: <description>`.

## First-time empty repo

This repository started with no commits. After the first commit:

```bash
git push -u origin main
```

If `git ls-remote origin` is empty, GitHub has no commits yet — push `main` rather than opening a PR.
