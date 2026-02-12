#!/usr/bin/env bash
#
# dotenv-sync install — Adds dotenv-sync to your shell PATH.
#
# Run this from inside the cloned repo:
#   ./install.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
DIM=$'\033[2m'
RESET=$'\033[0m'

info() { printf '%s%s  %s\n' "${CYAN}" "ℹ" "${RESET}  $*"; }
ok() { printf '%s%s  %s\n' "${GREEN}" "✔" "${RESET}  $*"; }

printf '\n%s📦 Setting up dotenv-sync%s\n\n' "\033[1m" "${RESET}"

# Make sure the script is executable
chmod +x "${SCRIPT_DIR}/dotenv-sync"

add_to_path() {
	local shell_rc="$1"
	local export_line="export PATH=\"${SCRIPT_DIR}:\$PATH\""

	if [[ -f "${shell_rc}" ]] && grep -qF "${SCRIPT_DIR}" "${shell_rc}"; then
		info "PATH already configured in ${shell_rc}"
		return
	fi

	printf '\n# dotenv-sync\n%s\n' "${export_line}" >>"${shell_rc}"
	ok "Added to PATH in ${shell_rc}"
}

# Detect shell
if [[ -n "${ZSH_VERSION:-}" ]] || [[ "${SHELL}" == */zsh ]]; then
	add_to_path "${HOME}/.zshrc"
elif [[ -n "${BASH_VERSION:-}" ]] || [[ "${SHELL}" == */bash ]]; then
	add_to_path "${HOME}/.bashrc"
	[[ -f "${HOME}/.bash_profile" ]] && add_to_path "${HOME}/.bash_profile"
else
	info "Could not detect your shell. Add this to your shell profile:"
	printf '  %sexport PATH="%s:$PATH"%s\n' "${DIM}" "${SCRIPT_DIR}" "${RESET}"
fi

printf '\n%s✅ Done!%s\n\n' "${GREEN}\033[1m" "${RESET}"
printf '  Restart your terminal (or source your shell profile), then:\n'
printf '  %sdotenv-sync init%s     — create a config in your project\n' "${CYAN}" "${RESET}"
printf '  %sdotenv-sync pull%s     — pull .env files from 1Password\n' "${CYAN}" "${RESET}"
printf '  %sdotenv-sync --help%s   — see all commands\n\n' "${CYAN}" "${RESET}"
