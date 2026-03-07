#!/bin/bash
# hooks/check-issue-active.sh
# PreToolUse hook — fires before every Bash tool call
# Checks that there's an active Linear issue before allowing file edits

ACTIVE_ISSUE_FILE=".claude/active-issue"

# Only check when Claude is about to run a command that modifies files
# We detect this by checking if the bash command contains common write patterns
BASH_COMMAND="${CLAUDE_TOOL_INPUT:-}"

# If no write-related command, let it through silently
if ! echo "$BASH_COMMAND" | grep -qE '(git add|git commit|touch |mkdir |cp |mv |rm |write|tee |sed -i|awk.*>)'; then
  exit 0
fi

# Check if active issue file exists and is non-empty
if [ ! -f "$ACTIVE_ISSUE_FILE" ] || [ ! -s "$ACTIVE_ISSUE_FILE" ]; then
  echo ""
  echo "⚠️  dev-flow: No active issue detected."
  echo "   You're about to make file changes, but no Linear issue is active."
  echo ""
  echo "   Run /start LIN-XX to begin a tracked session."
  echo "   Or if this is exploratory work, continue — this is just a reminder."
  echo ""
  # Exit 0 = warning only, doesn't block
  # Change to exit 1 to make this a hard block
  exit 0
fi

ISSUE_ID=$(cat "$ACTIVE_ISSUE_FILE")
echo "✓ Active issue: $ISSUE_ID"
exit 0
