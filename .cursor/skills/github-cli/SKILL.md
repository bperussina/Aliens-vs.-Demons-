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

Feature work goes on a branch, then a PR into `main`. Brody and Dad code in parallel, so push regularly and open the PR when the slice is done unless Brody says to wait. Follow the repo's pull-request conventions: summary + how to try it, HEREDOC body, no force-push to `main`. See `dev-philosophy`.

## Git safety

- After a finished slice: commit, `git push -u origin HEAD`, and `gh pr create` unless Brody says to wait.
- Never `git config`, `--no-verify`, or force-push `main`/`master`.
- Never skip hooks unless explicitly asked.
- Never dump feature work onto `main`.

## Spec Kit issues

When the user wants tasks on GitHub, use `/speckit-taskstoissues` (see `.cursor/skills/speckit-taskstoissues/SKILL.md`).

- Only create issues in `bperussina/Aliens-vs.-Demons-`.
- Deduplicate by task id (`T001`, `T002`, …) in existing issue titles.
- Title format: `T001: <description>`.
