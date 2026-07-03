#!/usr/bin/env bash
#
# Bootstraps this Neovim config on a fresh Mac.
#
# Usage:
#   1. Clone/copy this directory to ~/.config/nvim on the new machine
#      (or clone your dotfiles repo elsewhere and symlink it here).
#   2. Run: ~/.config/nvim/install.sh
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.config/nvim"

echo "==> Neovim config source: $CONFIG_DIR"

if [ "$CONFIG_DIR" != "$TARGET" ]; then
  if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
    backup="$TARGET.bak.$(date +%Y%m%d%H%M%S)"
    echo "==> $TARGET already exists, backing up to $backup"
    mv "$TARGET" "$backup"
  fi
  if [ ! -e "$TARGET" ]; then
    echo "==> Linking $CONFIG_DIR -> $TARGET"
    mkdir -p "$(dirname "$TARGET")"
    ln -s "$CONFIG_DIR" "$TARGET"
  fi
fi

echo "==> Linking lazygit config (delta as diff pager)"
mkdir -p "$HOME/.config/lazygit"
ln -sf "$CONFIG_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Homebrew not found, installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing packages via Homebrew"
# node/npm and jq are needed by Mason-installed tools (prettier, markdownlint,
# cspell) and the JSON-sort keymap, respectively. clangd/sourcekit-lsp come
# from Xcode command line tools (xcode-select --install), not Homebrew.
brew install neovim git ripgrep fd lazygit tree-sitter-cli node jq git-delta

if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Xcode command line tools not found, installing (needed for clangd/sourcekit-lsp)"
  xcode-select --install
fi

if ! brew list --cask font-meslo-lg-nerd-font >/dev/null 2>&1; then
  echo "==> Installing Meslo Nerd Font"
  brew install --cask font-meslo-lg-nerd-font
fi

echo "==> Verifying Nerd Font files are actually installed"
if find /Library/Fonts ~/Library/Fonts -iname "MesloLG*NerdFont*.ttf" 2>/dev/null | grep -q .; then
  echo "    Found Meslo Nerd Font files."
else
  echo "    WARNING: no Meslo Nerd Font files found in /Library/Fonts or ~/Library/Fonts." >&2
  echo "    Diagnostic icons, devicons and statusline glyphs will render as boxes" >&2
  echo "    without it. Try: brew reinstall --cask font-meslo-lg-nerd-font" >&2
fi

echo "==> Syncing plugins headlessly (this may take a minute)"
nvim --headless "+Lazy! sync" +qa

echo "==> Installing treesitter parsers"
nvim --headless -c "edit /tmp/nvim-ts-bootstrap.lua" -c "lua vim.wait(15000)" -c "qa" || true

echo "==> Installing Mason-managed LSP servers and CLI tools"
nvim --headless -c "MasonToolsInstall" -c "lua vim.wait(30000)" -c "qa" || true
nvim --headless -c "MasonInstall lua-language-server pyright typescript-language-server" -c "lua vim.wait(30000)" -c "qa" || true

cat <<'EOF'

Done. Notes:
  - Set your terminal font to "MesloLGL Nerd Font" (or "MesloLGL Nerd Font Mono")
    for icons to render correctly, matching your VS Code terminal font.
  - Run `:checkhealth` inside nvim to verify everything is wired up.
  - LSP servers, formatters (ruff/isort/prettier/clang-format/stylua) and
    linters (pylint/markdownlint/cspell) install automatically via Mason on
    first launch; run `:Mason` to check progress or add more.
  - clangd and sourcekit-lsp are picked up from the Xcode command line tools.
  - lazygit is configured to use delta as its diff pager. If you want git
    diff/log/show to render through delta everywhere (shell, :Bterm,
    :Gdiff), set `git config --global core.pager delta` and your preferred
    delta options (see https://dandavison.github.io/delta/configuration.html).
EOF
