#!/usr/bin/env bash
# Remove symlinks this repo created in each AI-agent skills dir.
# Only deletes symlinks pointing back into this repo; never touches copies/backups.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -a SKILL_DIRS=(
  "$HOME/.claude/skills"
  "${CODEX_HOME:-$HOME/.codex}/skills"
  "$HOME/.gemini/skills"
  "$HOME/.opencode/skills"
)

for dir in "${SKILL_DIRS[@]}"; do
  [ -d "$dir" ] || continue
  for skill in "$REPO_DIR"/*/; do
    [ -f "${skill}SKILL.md" ] || continue
    name="$(basename "$skill")"; target="$dir/$name"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "${skill%/}" ]; then
      rm "$target"; echo "unlink $dir/$name"
    fi
  done
done
echo "done."
