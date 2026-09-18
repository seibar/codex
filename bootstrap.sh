#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
codex_dir="${CODEX_HOME:-${HOME}/.codex}"
agents_dir="${HOME}/.agents"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_dir="${codex_dir}/backups/bootstrap-${timestamp}-$$"
created_backup=false

link_managed_path() {
  local source_path="$1"
  local target_path="$2"
  local backup_name="$3"

  mkdir -p "$(dirname -- "${target_path}")"

  if [[ -L "${target_path}" ]] && [[ "$(readlink "${target_path}")" == "${source_path}" ]]; then
    printf 'ok      %s -> %s\n' "${target_path}" "${source_path}"
    return
  fi

  if [[ -e "${target_path}" || -L "${target_path}" ]]; then
    mkdir -p "${backup_dir}"
    mv "${target_path}" "${backup_dir}/${backup_name}"
    created_backup=true
    printf 'backup  %s -> %s\n' "${target_path}" "${backup_dir}/${backup_name}"
  fi

  ln -s "${source_path}" "${target_path}"
  printf 'link    %s -> %s\n' "${target_path}" "${source_path}"
}

mkdir -p "${codex_dir}" "${agents_dir}"

link_managed_path "${repo_dir}/AGENTS.global.md" "${codex_dir}/AGENTS.md" "AGENTS.md"
link_managed_path "${repo_dir}/config.toml" "${codex_dir}/config.toml" "config.toml"
link_managed_path "${repo_dir}/hooks.json" "${codex_dir}/hooks.json" "hooks.json"
link_managed_path "${repo_dir}/agents" "${codex_dir}/agents" "agents"
link_managed_path "${repo_dir}/rules" "${codex_dir}/rules" "rules"
link_managed_path "${repo_dir}/skills" "${agents_dir}/skills" "dot-agents-skills"

if [[ "${created_backup}" == true ]]; then
  printf '\nExisting files were preserved in %s\n' "${backup_dir}"
fi
