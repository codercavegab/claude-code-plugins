# standup-format — Daily standup style guide

This skill activates automatically when the user mentions standup, daily update, 
yesterday/today summary, or when the standup-builder agent runs.

## Standup philosophy

A good standup has three qualities:
- **Brief** — one line per item, no paragraphs
- **Specific** — mention issue IDs, PR numbers, or feature names
- **Honest** — if there are blockers, name them explicitly

## Format rules

Always use this exact structure:
1. ✅ Yesterday — what was completed or progressed
2. 🔨 Today — what you plan to work on
3. 🚧 Blockers — anything blocking progress (or "None")

## Tone

- Write in first person, present tense: "Working on X", not "I was working on X"
- Avoid vague language: "Made progress on auth" → "Fixed token expiry bug in auth middleware (LIN-42)"
- Include issue IDs when available: "Completed LIN-42, starting LIN-47"

## Length

- Each section: 1-3 bullets max
- Each bullet: 1 line max (under 100 characters)
- Total standup: fits in a single Slack message without expanding
