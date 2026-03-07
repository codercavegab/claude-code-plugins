# /wrap — Close the current work session

Wrap up the current session cleanly.
Reads the active issue from `.claude/active-issue`, summarizes what was done,
generates a conventional commit message from the actual diff, and updates Linear.

## Usage

```
/wrap
/wrap --no-commit   (summarize only, don't commit yet)
/wrap --draft-pr    (create a draft PR on GitHub after committing)
```

## What this command does

1. **Read active issue** from `.claude/active-issue`
2. **Fetch issue from Linear** — confirm it's still open and in progress
3. **Get the git diff** — run `git diff HEAD` to see exactly what changed
4. **Generate commit message** — conventional commits format, based on the real diff
5. **Show summary** — what was changed, what files, lines added/removed
6. **Ask confirmation** — show the commit message and ask before running `git commit`
7. **Update Linear** — move issue status to "In Review" via MCP
8. **Optionally create draft PR** — if `--draft-pr` flag is passed, create it via GitHub MCP

## Instructions for Claude

When this command is invoked:

- Read `.claude/active-issue` to get the current issue ID
- If the file doesn't exist or is empty, say: "No active issue found. Did you start a session with /start?"
- Fetch the issue from Linear via MCP to get title and description
- Run `git diff HEAD --stat` to see which files changed
- Run `git diff HEAD` to read the actual changes
- Generate a commit message following conventional commits:
  - Format: `<type>(<scope>): <description>`
  - Types: feat, fix, refactor, docs, test, chore
  - Scope: the main module or folder affected
  - Description: short, imperative, lowercase
  - Body: bullet list of main changes (optional, only if >3 files changed)
- Show the full summary before doing anything
- Ask: "Commit with this message? (y/n)"
- On confirmation: run `git add -A && git commit -m "<message>"`
- Update the Linear issue status to "In Review" via MCP
- Clear `.claude/active-issue`

## Commit message examples

Good:
```
fix(auth): prevent redirect loop on expired session

- Add check for token expiry before redirect
- Clear session cookie on 401 response
- Update middleware to handle edge case
```

Bad:
```
fixed stuff
updated login
WIP
```

## Example output

```
╔══════════════════════════════════════════╗
║  Wrapping up: LIN-42                     ║
║  Fix login redirect loop                 ║
╚══════════════════════════════════════════╝

Changed files:
  M  src/auth/login.ts          (+24 / -8)
  M  src/middleware/redirect.ts (+11 / -3)

Proposed commit:
  fix(auth): prevent redirect loop on expired session

Linear: will move LIN-42 → "In Review"

Commit with this message? (y/n)
```
