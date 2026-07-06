# Agent Skills

Portable [Agent Skills](https://agentskills.io) — the open `SKILL.md` standard.
Each top-level folder with a `SKILL.md` is one skill. The same folder works in
Claude Code, Codex CLI, Gemini CLI, Cursor, OpenCode, and any tool that reads the spec.

## Skills

| Skill | What it does |
|-------|--------------|
| `idea-research` | Research a side-project/business idea for profitability (personalized — private). |
| `postgresql-vps-agent` | Secure PostgreSQL setup on a VPS: TLS, `pg_hba`, roles, backup/restore, firewall, cleanup. |

## Install on a new machine

```bash
git clone git@github.com:manooi/skills.git
cd skills
./install.sh
```

`install.sh` detects which agent tools are installed and symlinks every skill folder
into each one's skills dir (`~/.claude/skills`, `~/.codex/skills`, `~/.gemini/skills`,
`~/.opencode/skills`). The repo stays the single source of truth — pull the repo and
edits show up in every tool instantly, no re-copy.

- Limit to some tools: `TOOLS="claude codex" ./install.sh`
- Remove the links: `./uninstall.sh`
- An existing non-symlink at a target is backed up to `<name>.bak.<timestamp>`, not deleted.
- Add a tool: append a `tool:home` row to `TOOL_HOMES` in `install.sh`.

## Adding a skill

Create `my-skill/SKILL.md`, then re-run `./install.sh`.

```markdown
---
name: my-skill          # must equal the folder name; lowercase, digits, hyphens; <=64 chars
description: One line, <=1024 chars. Say what it does AND when the agent should trigger it.
---

# My Skill
...instructions...
```

Keep it valid per the Agent Skills spec so the one folder stays portable across every
tool. Bundle extra files under the skill folder (`references/`, `scripts/`, `assets/`)
and link them from `SKILL.md` — they load on demand (progressive disclosure).
