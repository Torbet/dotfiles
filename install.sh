#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$HOME/.config"

ln -s "$ROOT/.config/ghostty"       "$HOME/.config/ghostty"
ln -s "$ROOT/.config/nvim"          "$HOME/.config/nvim"
ln -s "$ROOT/.config/tmux"          "$HOME/.config/tmux"
ln -s "$ROOT/.config/starship.toml" "$HOME/.config/starship.toml"
ln -s "$ROOT/.zshrc"                "$HOME/.zshrc"
