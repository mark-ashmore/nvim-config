# nvim-config

Personal Neovim configuration, built to replicate a gruvbox dark-hard look and
feel (from a prior vim + VS Code setup) with modern IDE features layered on
top: LSP, autocompletion, formatting/linting, git/GitHub tooling, and a
handful of quality-of-life polish plugins. Designed to be reproducible across
multiple Macs via `install.sh`.

## Install on a new Mac

```bash
git clone https://github.com/mark-ashmore/nvim-config.git ~/.config/nvim
~/.config/nvim/install.sh
```

The script:
- Symlinks itself into `~/.config/nvim` if run from elsewhere.
- Symlinks `lazygit/config.yml` into `~/.config/lazygit/config.yml`.
- Installs Homebrew (if missing) and required packages: `neovim`, `git`,
  `ripgrep`, `fd`, `lazygit`, `tree-sitter-cli`, `node`, `jq`, `git-delta`.
- Checks for Xcode command line tools (needed for `clangd`/`sourcekit-lsp`).
- Installs the Meslo Nerd Font and **verifies the font files actually
  exist** on disk (not just that the Homebrew cask is registered).
- Syncs plugins headlessly (`lazy.nvim`), installs treesitter parsers, and
  installs Mason-managed LSP servers/formatters/linters.

After installing, set your terminal's font to a Nerd Font variant (e.g.
"MesloLGL Nerd Font") so gutter/statusline icons render correctly, and run
`:checkhealth` inside Neovim to confirm everything is wired up.

## Structure

```
init.lua                   Entry point, loads config/ modules in order
lua/config/
  options.lua               Plain vim.opt settings (UI, indentation, etc.)
  keymaps.lua                Leader-key mappings, custom commands
  autocmds.lua                Autocommands (yank highlight, trim whitespace, etc.)
  lazy.lua                     lazy.nvim bootstrap + plugin spec loader
lua/plugins/                One file per plugin/feature area (see below)
lazy-lock.json              Pinned plugin versions (commit after `:Lazy update`)
lazygit/config.yml           lazygit config (delta as diff pager)
install.sh                   Bootstrap script for a fresh Mac
```

## Colorscheme

`gruvbox.nvim` (ellisonleao), `contrast = "hard"`. Highlight overrides live in
`lua/plugins/colorscheme.lua` for things gruvbox doesn't quite match out of
the box (cursor line number, diagnostic sign background, fold column, etc.).

## LSP, completion, formatting, linting

- **LSP**: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`.
  Mason-managed servers: `lua_ls`, `pyright`, `ts_ls`, `ruff`. System servers
  (from Xcode CLT): `clangd`, `sourcekit`.
  - Python: `ruff` handles linting (broadened rule set: `E W F I N UP B SIM
    C90 PL`) and import organizing; `pyright` owns hover/type info (ruff's
    hover is explicitly disabled so they don't conflict).
  - Inlay hints are enabled globally where supported (`lua_ls`, `ts_ls`; not
    supported by `pyright`/`ruff`). Toggle with `<leader>uh`.
- **Completion**: `nvim-cmp` with LSP/buffer/path/snippet (LuaSnip) sources.
- **Formatting**: `conform.nvim`, format-on-save. Python via
  `ruff_organize_imports` + `ruff_format`; JS/TS/JSON/YAML/HTML/CSS/Markdown
  via `prettier`; C/C++ via `clang_format`; Lua via `stylua`.
- **Linting**: `nvim-lint` for markdown (`markdownlint-cli2`, `cspell`) and
  git commit messages (`cspell`). Python linting comes from the ruff LSP
  above, not `nvim-lint`.
- **Diagnostics**: Nerd Font icons in the gutter instead of default `E/W/I/H`
  letters (configured in `options.lua`).
- **Problems panel**: `trouble.nvim` (`<leader>xx` / `<leader>xd` / `<leader>xq`
  / `<leader>xl`).

## Git / GitHub

- `gitsigns.nvim` — inline hunk signs + full keymap set (staging, resetting,
  previewing, blame, hunk text object).
- `vim-fugitive` — `<leader>gs` for `:Git` status.
- `diffview.nvim` — `<leader>gd` diff view, `<leader>gh` file history (graph).
- `lazygit.nvim` — `<leader>gg` floating LazyGit.
- `octo.nvim` — `<leader>gp` GitHub PR list, `<leader>gi` issue list (uses
  existing `gh` CLI auth).
- `git-delta` — configured as the pager for both the shell (`core.pager`,
  set outside this repo) and lazygit (`lazygit/config.yml`); also available
  inside Neovim via `:Gdiff [args]` / `<leader>gD`, which runs `git diff`
  in a bottom terminal split so delta renders it.

## Other plugins

- `telescope.nvim` — fuzzy finder: `<leader>ff` files, `<leader>fg` grep,
  `<leader>fb` buffers, `<leader>fh` help, `<leader>fr` recent files.
- `nvim-tree.lua` — file explorer, `<leader>e` toggle (loads eagerly so
  `nvim .` opens it instead of netrw; press `g?` inside the tree for its
  own help).
- `noice.nvim` — centered floating cmdline instead of the bottom bar, plus
  nicer LSP hover/signature float rendering. LSP progress messages
  (e.g. Pyright "analyzing") show in the lualine statusline instead of
  popup toasts. Disable at runtime with `:Noice disable` (`:Noice enable`
  to re-enable), or flip `enabled = false` in `lua/plugins/noice.lua` for a
  hard disable.
- `lualine.nvim` — statusline (mode, branch, diff, diagnostics, LSP status,
  filetype, location).
- `which-key.nvim` — shows available keymaps after a short pause on a
  leader prefix.
- `nvim-autopairs` / `nvim-surround` — auto-closing brackets/quotes, and
  `ys`/`cs`/`ds` surround operators.
- `render-markdown.nvim` — inline markdown rendering.
- `rainbow_csv.nvim` — CSV/TSV column highlighting.
- `treesitter` (`main` branch) — syntax highlighting/parsing for lua, vim,
  vimdoc, bash, python, js, ts, json, markdown, yaml, html, css.

## Custom commands

| Command / keymap | Purpose |
|---|---|
| `:Bterm` / `bterm` (cabbrev) | Open a terminal in a bottom split |
| `:Gdiff [args]` / `<leader>gD` | `git diff` through delta in a bottom split |
| `:ReloadConfig` | Reload `lua/config/*.lua` (options/keymaps/autocmds) without restarting nvim. Plugin changes under `lua/plugins/*.lua` need `:Lazy reload <plugin-name>` instead. |

## Leader-key cheat sheet

Leader is `,`. `which-key.nvim` will show a live menu after pressing a
prefix, but the main ones:

| Keys | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader><cr>` | Clear search highlight |
| `<leader>bd` / `<leader>ba` | Delete buffer / delete all buffers |
| `<leader>l` / `<leader>h` | Next / previous buffer |
| `<leader>tn` / `<leader>to` / `<leader>tc` | New / only / close tab |
| `<leader>cd` | `cd` to current buffer's directory |
| `<leader>ss` | Toggle spellcheck |
| `<leader>js` | Sort JSON (buffer or visual selection) via `jq -S` |
| `<leader>e` | Toggle file explorer |
| `<leader>ff/fg/fb/fh/fr` | Telescope: files / grep / buffers / help / recent |
| `<leader>gs` | Git status (fugitive) |
| `<leader>gd` / `<leader>gh` | Diffview / file history |
| `<leader>gg` | LazyGit |
| `<leader>gp` / `<leader>gi` | GitHub PR list / issue list (octo) |
| `<leader>gD` | Git diff through delta |
| `<leader>hs/hr/hS/hR/hu/hp/hb` | Gitsigns: stage/reset/stage-buffer/reset-buffer/undo-stage/preview/blame hunk |
| `<leader>tb` | Toggle inline git blame |
| `]c` / `[c` | Next / previous git hunk |
| `gd` / `K` | Go to definition / hover docs |
| `<leader>rn` / `<leader>ca` | Rename symbol / code action |
| `<leader>uh` | Toggle inlay hints |
| `<leader>fm` | Format buffer |
| `<leader>xx/xd/xq/xl` | Trouble: workspace / buffer diagnostics, quickfix, loclist |

## Known limitations

- `noice.nvim` requires a real UI attached; its config is a no-op under
  `nvim --headless`, so headless testing can only confirm it loads without
  a Lua error, not that it renders correctly.
- Diagnostic sign icons require a real Nerd Font in the terminal — see the
  install script's font verification step.
