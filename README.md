# dev-flow

> Personal dev workflow plugin for Claude Code. Connect your Linear issues to your codebase — start focused, ship clean.

This repo is both a **Claude Code marketplace** and the source for the `dev-flow` plugin.

---

## Install

```bash
# 1. Add this repo as a marketplace
claude marketplace add gabriel https://github.com/tu-usuario/dev-flow

# 2. Install the plugin
/plugin install dev-flow@gabriel
```

That's it. You now have `/start`, `/wrap`, and two auto-activating skills.

---

## What it does

### `/start LIN-42`
Kicks off a focused work session on a Linear issue:
- Fetches the issue title, description, and priority via Linear MCP
- Creates `feature/<issue-name>` branch automatically
- Scans your codebase for relevant files
- Writes the active issue ID to `.claude/active-issue`
- Presents a work plan before touching anything

### `/wrap`
Closes the session cleanly:
- Reads `.claude/active-issue` to know what you were working on
- Runs `git diff HEAD` to see the actual changes
- Generates a conventional commit message from the real diff (not from memory)
- Asks for confirmation before committing
- Moves the Linear issue to "In Review" automatically

### `dev-context` skill (always on)
Keeps Claude aware of your conventions without you having to repeat them:
- Branch naming: `feature/<description>`, no ticket IDs
- Commit style: conventional commits, imperative, lowercase
- Code discipline: read before editing, one change at a time

### `rubber-duck` skill (activates when you're stuck)
When Claude detects you're going in circles — repeated errors, reverted changes, frustration — it switches to Socratic debugging mode. Asks one targeted question instead of rewriting your code.

### `PreToolUse` hook
Before any file-modifying command, checks that `.claude/active-issue` exists. If not, shows a reminder to run `/start`. Non-blocking by default — change `exit 0` to `exit 1` in `hooks/check-issue-active.sh` to make it a hard block.

---

## Requirements

- Claude Code (late 2025 build or later)
- Linear MCP configured: `claude mcp add linear npx @linear/mcp@latest`
- Git repo initialized in your project
- A Linear account with real issues

---

## Repo structure

```
dev-flow/
├── marketplace.json               ← makes this repo a Claude Code marketplace
├── plugins/
│   └── dev-flow/
│       ├── .claude-plugin/
│       │   └── plugin.json        ← plugin manifest
│       ├── commands/
│       │   ├── start.md           ← /start command
│       │   └── wrap.md            ← /wrap command
│       ├── skills/
│       │   ├── dev-context.md     ← conventions skill
│       │   └── rubber-duck.md     ← socratic debugging skill
│       └── hooks/
│           └── check-issue-active.sh  ← PreToolUse guard
└── README.md
```

---

## Customization

Fork the repo, then edit:

- **Branch naming** → `plugins/dev-flow/skills/dev-context.md`
- **Make the hook block instead of warn** → change `exit 0` to `exit 1` in `hooks/check-issue-active.sh`
- **Add your team conventions** → append to `skills/dev-context.md`
- **Add more commands** → create `.md` files in `commands/` and register them in `plugin.json`

---

## Context

Built as a demo for a YouTube video about Claude Code Plugins. The point of this repo: a marketplace is just a GitHub repo with a `marketplace.json`. A plugin is just a folder with a `plugin.json` and some Markdown files. No magic.
