-- Installs the CLI formatters/linters used by conform.nvim and nvim-lint,
-- matching the VS Code extensions: black-formatter, isort, pylint,
-- prettier-vscode, vscode-markdownlint, code-spell-checker.
-- (black/isort/pylint consolidated into ruff, which formats, sorts imports,
-- and lints python in one tool via the LSP configured in lsp.lua)
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = {
      "ruff",
      "prettier",
      "markdownlint-cli2",
      "cspell",
      "clang-format",
      "stylua",
    },
  },
}
