#!/bin/bash
# branch-check.sh
# PreToolUse hook — fires before Bash
# Blocks git push directly to main or master

# Read JSON input from stdin
INPUT=$(cat)

# Extract the bash command
COMMAND=$(echo "$INPUT" | grep -o '"command":"[^"]*"' | head -1 | cut -d'"' -f4)

# Only act on git push commands
if ! echo "$COMMAND" | grep -qE 'git push'; then
  exit 0
fi

# Get the current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)

if [ -z "$CURRENT_BRANCH" ]; then
  exit 0
fi

# Block push to main or master
if echo "$CURRENT_BRANCH" | grep -qE '^(main|master)$'; then
  echo ""
  echo "🚫 dev-flow: Direct push to '$CURRENT_BRANCH' is not allowed."
  echo ""
  echo "   Create a feature branch and open a Pull Request instead:"
  echo "   git checkout -b feature/your-feature-name"
  echo "   git push origin feature/your-feature-name"
  echo ""
  exit 2
fi

echo "✓ dev-flow: Pushing from branch '$CURRENT_BRANCH' — OK"
exit 0
