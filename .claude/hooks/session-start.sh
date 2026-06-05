#!/bin/bash
set -euo pipefail

# Only run in remote cloud environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Restore universal coding standards to user-level CLAUDE.md
mkdir -p ~/.claude
cp "$CLAUDE_PROJECT_DIR/.claude/universal-claude.md" ~/.claude/CLAUDE.md

# Copy all 23 scan commands to user-level commands directory
mkdir -p ~/.claude/commands
cp "$CLAUDE_PROJECT_DIR/.claude/commands/"*.md ~/.claude/commands/

echo "Session ready: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l) scan commands + universal coding standards installed"
