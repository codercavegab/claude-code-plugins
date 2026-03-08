# pr-conventions — Pull Request writing guide

This skill activates automatically when the user mentions PR, pull request, 
opening a PR, or when the pr-builder agent runs.

## PR title conventions

Always follow Conventional Commits format:
- `feat(scope): description` — new feature
- `fix(scope): description` — bug fix  
- `refactor(scope): description` — code change without behavior change
- `docs(scope): description` — documentation only
- `test(scope): description` — tests only
- `chore(scope): description` — build, deps, tooling

Rules for the title:
- Lowercase after the colon
- Imperative mood: "add login" not "added login" or "adding login"
- Under 72 characters
- No period at the end

## PR description quality

A good PR description answers:
1. **What** — what technically changed
2. **Why** — the business or user reason for the change
3. **How to test** — concrete steps, not "test it"

## Draft vs Ready

- Always create as **draft** first — this is the safe default
- Only mark as ready when tests pass and self-review is done

## Branch naming

- `feature/short-description` — new features
- No ticket IDs in branch names
- Lowercase, hyphens only, max 50 chars
