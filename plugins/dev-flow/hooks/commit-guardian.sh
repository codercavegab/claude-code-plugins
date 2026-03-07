#!/bin/bash
# commit-guardian.sh
# PreToolUse hook — fires before Bash
# Blocks git commits that don't follow Conventional Commits format

# Read JSON input from stdin
INPUT=$(cat)

# Extract the bash command
COMMAND=$(echo "$INPUT" | grep -o '"command":"[^"]*"' | head -1 | cut -d'"' -f4)

# Only act on git commit commands
if ! echo "$COMMAND" | grep -qE 'git commit'; then
  exit 0
fi

# Extract the commit message from -m flag
MSG=$(echo "$COMMAND" | grep -oP '(?<=-m ")[^"]*' | head -1)

# If no -m message found (e.g. interactive commit), let it through
if [ -z "$MSG" ]; then
  exit 0
fi

# Check if message follows Conventional Commits
# Valid types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert
if echo "$MSG" | grep -qE '^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .+'; then
  echo "✓ dev-flow: Commit message follows Conventional Commits"
  exit 0
else
  echo ""
  echo "❌ dev-flow: Commit message doesn't follow Conventional Commits."
  echo ""
  echo "   Required format:  type(scope): description"
  echo "   Example:          feat(auth): add login with Google"
  echo "   Valid types:      feat, fix, docs, style, refactor, test, chore, perf"
  echo ""
  echo "   Your message was: $MSG"
  echo ""
  # Exit 2 = block the operation and show message to Claude
  exit 2
fi
