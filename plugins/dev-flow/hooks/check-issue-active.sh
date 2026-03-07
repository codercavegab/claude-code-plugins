#!/bin/bash
# hooks/check-issue-active.sh
# PreToolUse hook — fires before Write, Edit, and MultiEdit tool calls
# Checks that there's an active Linear issue before allowing file edits

ACTIVE_ISSUE_FILE=".claude/active-issue"

# Read the JSON input from stdin (this is how hooks receive data)
INPUT=$(cat)

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
  # Change to exit 2 to make this a hard block
  exit 0
fi

ISSUE_ID=$(cat "$ACTIVE_ISSUE_FILE")
echo "✓ dev-flow: Active issue $ISSUE_ID"
exit 0