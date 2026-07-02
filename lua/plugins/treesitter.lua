local parsers = {
  "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript",
  "json", "markdown", "markdown_inline", "yaml", "html", "css",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        pcall(vim.treesitter.start)
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldenable = false
      end,
    })
  end,
}
