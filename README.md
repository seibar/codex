# Personal Codex setup

Version-controlled personal configuration for Codex. The repository is the
source of truth; `bootstrap.sh` links supported files into their user-scoped
Codex locations.

## Managed paths

| Repository path | Installed path |
| --- | --- |
| `AGENTS.global.md` | `~/.codex/AGENTS.md` |
| `config.toml` | `~/.codex/config.toml` |
| `hooks.json` | `~/.codex/hooks.json` |
| `agents/` | `~/.codex/agents` |
| `rules/` | `~/.codex/rules` |
| `skills/` | `~/.agents/skills` |

Codex's built-in `~/.codex/skills/.system` directory is intentionally left
alone. Current Codex releases discover personal skills from `~/.agents/skills`
and support symlinked skill directories.

## Bootstrap

```sh
./bootstrap.sh
```

The script is idempotent. Before replacing a real file or directory, it moves
the existing target into a timestamped directory under
`~/.codex/backups/`. Authentication, conversations, memories, caches, SQLite
databases, and other generated state remain local and untracked.

After changing skills or configuration, restart Codex if the update is not
picked up automatically.

## Layout

- `AGENTS.md`: instructions for maintaining this repository only.
- `AGENTS.global.md`: personal instructions loaded globally by Codex.
- `agents/`: personal custom-agent TOML files.
- `skills/`: one directory per personal skill, each containing `SKILL.md`.
- `plugins/`: personal plugin source; install plugins through Codex rather than
  linking over the generated plugin cache.
- `rules/`: command approval rules.

References: [Codex skills](https://developers.openai.com/codex/skills),
[advanced configuration](https://developers.openai.com/codex/config-advanced),
and [subagents](https://developers.openai.com/codex/subagents).
