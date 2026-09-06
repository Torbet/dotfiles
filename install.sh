#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

brew bundle --file="$ROOT/Brewfile"

mkdir -p "$HOME/.config"

for item in ghostty nvim tmux starship.toml; do
  ln -sfn "$ROOT/.config/$item" "$HOME/.config/$item"
done

ln -sfn "$ROOT/.zshrc" "$HOME/.zshrc"
