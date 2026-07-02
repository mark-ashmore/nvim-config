-- Diagnostics on save, matching VS Code's vscode-markdownlint and
-- code-spell-checker extensions (python linting comes from the ruff LSP
-- configured in lsp.lua instead of nvim-lint)
return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = { "markdownlint-cli2", "cspell" },
      gitcommit = { "cspell" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
