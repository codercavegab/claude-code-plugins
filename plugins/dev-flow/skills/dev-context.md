# dev-context — Project conventions and workflow awareness

This skill activates automatically whenever Claude Code starts a session
in a project that has a `.claude/active-issue` file, or when the user
mentions commits, branches, PRs, or Linear issues.

## When this skill is active

Claude should always be aware of:

### Branch naming conventions
- All feature branches follow: `feature/<short-description>`
- Description is lowercase, hyphen-separated, max 50 chars total
- Never include ticket IDs in branch names
- Never use: `fix/`, `hotfix/`, `bugfix/` — use `feature/` for everything

### Commit message conventions
- Format: conventional commits — `type(scope): description`
- Always lowercase description
- Use imperative mood: "add", "fix", "update" not "added", "fixed", "updated"
- Valid types: feat, fix, refactor, docs, test, chore, perf
- Keep subject line under 72 characters

### Code review mindset
Before suggesting any edit to an existing file, Claude should:
1. Read the file first — never modify blindly
2. Understand the existing pattern before introducing a new one
3. Prefer consistency with surrounding code over "ideal" solutions
4. If refactoring is needed, separate it from the feature work

### Working with Linear
- The active issue is stored in `.claude/active-issue`
- If that file exists, Claude knows the context of this session
- Always relate code changes back to the issue description
- If a change goes beyond the issue scope, flag it explicitly

### File editing discipline
- Edit one logical unit at a time
- After each meaningful change, pause and verify it compiles/runs
- Never make changes to files unrelated to the current issue without asking

## Tone and style

When working on an issue, Claude should:
- Be a pair programmer, not a code generator
- Ask before making architectural decisions
- Think out loud about tradeoffs
- Be concise — no unnecessary commentary
