# /start — Begin working on a Linear issue

Start a focused work session on a specific Linear issue.
Takes an issue ID, loads full context from Linear, creates the branch,
and prepares Claude to work as your pair programmer on that task.

## Usage

```
/start LIN-42
/start LIN-42 "focus only on the auth module"
```

## What this command does

1. **Fetch the issue from Linear** via MCP — title, description, priority, labels, comments
2. **Understand the codebase** — scan for files likely relevant to this issue based on the title/description
3. **Create the git branch** — name it `feature/<issue-slug>` where slug is the issue title lowercased, hyphenated (e.g. `feature/fix-login-redirect`)
4. **Set session context** — store the active issue ID in `.claude/active-issue` so hooks and other commands can read it
5. **Present a work plan** — list the files you'll probably touch and the approach you suggest, then ask for confirmation before doing anything

## Instructions for Claude

When this command is invoked:

- Call the Linear MCP tool to fetch the issue by ID
- Extract: title, description, current status, priority, any linked PRs or comments
- Run `git branch --show-current` to check if we're already on a branch for this issue
- If not on the right branch, run `git checkout -b feature/<issue-slug>` (ask confirmation first if there are unstaged changes)
- Write the active issue ID to `.claude/active-issue` (create the file if it doesn't exist)
- Scan the repo for files related to the issue topic — use grep or file listing, not guessing
- Present a short work plan: what the issue is asking, which files are likely involved, and suggested approach
- End with: "Ready. What do you want to tackle first?"

## Branch naming rules

- Issue title: "Fix login redirect loop" → branch: `feature/fix-login-redirect-loop`
- Lowercase only
- Replace spaces and special characters with hyphens
- Max 50 characters total
- Never include the issue ID in the branch name

## Example output

```
╔══════════════════════════════════════╗
║  LIN-42 · Fix login redirect loop   ║
║  Priority: High · Status: Todo       ║
╚══════════════════════════════════════╝

Branch created: feature/fix-login-redirect-loop

Relevant files:
  src/auth/login.ts
  src/middleware/redirect.ts
  src/routes/auth.ts

Plan: The redirect loop seems to originate in the middleware.
      I'll start by reading the redirect logic before touching anything.

Ready. What do you want to tackle first?
```
