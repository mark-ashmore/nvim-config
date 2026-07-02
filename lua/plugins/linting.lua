-- Diagnostics on save, matching VS Code's pylint, vscode-markdownlint and
-- code-spell-checker extensions
return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "pylint" },
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
