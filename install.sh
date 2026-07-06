#!/usr/bin/env bash
# Fan-out this repo's skills into every installed AI-agent skills dir via symlink.
# SKILL.md is the open Agent Skills standard (agentskills.io) — same file, many tools.
# Repo stays the source of truth; edits propagate through the symlinks.
#
#   ./install.sh                 # link into every tool detected on this machine
#   TOOLS="claude codex" ./install.sh   # force a specific set
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# tool -> home dir that must exist for the tool to be considered "installed".
# Skills go into "<home>/skills". Add a row to support another tool.
declare -a TOOL_HOMES=(
  "claude:$HOME/.claude"
  "codex:${CODEX_HOME:-$HOME/.codex}"
  "gemini:$HOME/.gemini"
  "opencode:$HOME/.opencode"
)

# Optional filter: TOOLS="claude codex" picks a subset.
want() { [ -z "${TOOLS:-}" ] && return 0; [[ " $TOOLS " == *" $1 "* ]]; }

link_into() {  # $1=skills_dir  $2=skill_src
  local dir="$1" src="$2" name target
  name="$(basename "$src")"; target="$dir/$name"
  mkdir -p "$dir"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "  ok    $name"; return
  fi
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.bak.$(date +%s)"; echo "  backup $name (was a real file)"
  fi
  ln -sfn "$src" "$target"; echo "  link  $name"
}

total=0
for row in "${TOOL_HOMES[@]}"; do
  tool="${row%%:*}"; home="${row#*:}"
  want "$tool" || continue
  [ -d "$home" ] || { echo "skip  $tool (not installed: $home)"; continue; }
  echo "$tool -> $home/skills"
  for skill in "$REPO_DIR"/*/; do
    [ -f "${skill}SKILL.md" ] || continue
    link_into "$home/skills" "${skill%/}"; total=$((total+1))
  done
done
echo "done. $total link(s) created/verified."
