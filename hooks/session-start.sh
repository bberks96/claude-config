#!/usr/bin/env bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

rm -rf /tmp/claude-config-pull
git clone --depth=1 --quiet https://github.com/bberks96/claude-config.git /tmp/claude-config-pull

mkdir -p ~/.claude/commands
cp /tmp/claude-config-pull/universal-claude.md ~/.claude/CLAUDE.md
cp /tmp/claude-config-pull/commands/*.md ~/.claude/commands/

echo "Session ready: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l) scan commands + universal coding standards installed"
