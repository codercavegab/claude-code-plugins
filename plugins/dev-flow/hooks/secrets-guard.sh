#!/bin/bash
# secrets-guard.sh
# PreToolUse hook — fires before Write or Edit
# Scans content about to be written for hardcoded secrets

# Read JSON input from stdin
INPUT=$(cat)

# Extract the content being written
CONTENT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    # Try to get content from different tool input shapes
    content = data.get('tool_input', {}).get('content', '') or data.get('tool_input', {}).get('new_string', '')
    print(content)
except:
    pass
" 2>/dev/null)

if [ -z "$CONTENT" ]; then
  exit 0
fi

FOUND=0
WARNINGS=""

# Check for common secret patterns
if echo "$CONTENT" | grep -qiE 'api[_-]?key\s*[=:]\s*["\x27][A-Za-z0-9_\-]{16,}'; then
  WARNINGS="$WARNINGS\n   - API key pattern detected"
  FOUND=1
fi

if echo "$CONTENT" | grep -qiE '(secret|password|passwd|pwd)\s*[=:]\s*["\x27][^"\x27\s]{8,}'; then
  WARNINGS="$WARNINGS\n   - Password/secret pattern detected"
  FOUND=1
fi

if echo "$CONTENT" | grep -qE 'sk-[A-Za-z0-9]{32,}'; then
  WARNINGS="$WARNINGS\n   - OpenAI API key pattern detected (sk-...)"
  FOUND=1
fi

if echo "$CONTENT" | grep -qE 'ghp_[A-Za-z0-9]{36}'; then
  WARNINGS="$WARNINGS\n   - GitHub Personal Access Token detected (ghp_...)"
  FOUND=1
fi

if echo "$CONTENT" | grep -qE 'AKIA[0-9A-Z]{16}'; then
  WARNINGS="$WARNINGS\n   - AWS Access Key ID detected (AKIA...)"
  FOUND=1
fi

if [ "$FOUND" -eq 1 ]; then
  echo ""
  echo "🔐 dev-flow: Possible hardcoded secret detected in file content."
  echo -e "$WARNINGS"
  echo ""
  echo "   Use environment variables instead:"
  echo "   const key = process.env.API_KEY"
  echo ""
  echo "   And add the variable to .env (which should be in .gitignore)"
  echo ""
  # Exit 2 = block and show message to Claude
  exit 2
fi

exit 0
