#!/bin/bash
# no-console-log.sh
# PostToolUse hook — fires after Write or Edit
# Scans the file that was just written for console.log statements

# Read JSON input from stdin
INPUT=$(cat)

# Extract the file path from the tool input
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | cut -d'"' -f4)

# If no file path found, exit silently
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only check JS/TS files
if ! echo "$FILE_PATH" | grep -qE '\.(js|jsx|ts|tsx)$'; then
  exit 0
fi

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Count console.log occurrences
COUNT=$(grep -c "console\.log" "$FILE_PATH" 2>/dev/null || echo 0)

if [ "$COUNT" -gt 0 ]; then
  echo ""
  echo "⚠️  dev-flow: Found $COUNT console.log() in $FILE_PATH"
  echo "   Remember to remove debug statements before pushing to production."
  echo "   Lines with console.log:"
  grep -n "console\.log" "$FILE_PATH" | head -5
  echo ""
fi

exit 0
