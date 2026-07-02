-- Installs the CLI formatters/linters used by conform.nvim and nvim-lint,
-- matching the VS Code extensions: black-formatter, isort, pylint,
-- prettier-vscode, vscode-markdownlint, code-spell-checker.
-- (black-formatter swapped for ruff, which handles python formatting)
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = {
      "ruff",
      "isort",
      "pylint",
      "prettier",
      "markdownlint-cli2",
      "cspell",
      "clang-format",
      "stylua",
    },
  },
}
