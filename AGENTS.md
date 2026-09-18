# Personal Codex setup repository

This repository is the version-controlled collection of AJ's personal Codex
configuration, global instructions, custom agents, skills, hooks, rules, and
plugin source. Files managed here are linked into their user-scoped Codex
locations by `bootstrap.sh`.

- Keep global behavior in `AGENTS.global.md`; `AGENTS.md` applies only to this
  repository.
- Update `README.md` and `bootstrap.sh` together when adding a managed path.
- Never commit credentials, conversation history, caches, databases, or other
  generated Codex state.
- Validate configuration formats and rerun the bootstrap after changing an
  installed path.
