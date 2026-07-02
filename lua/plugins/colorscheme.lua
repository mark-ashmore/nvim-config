return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",
      terminal_colors = true,
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
      },
      overrides = {
        -- Match the teal ruler accent used in the VS Code setup
        ColorColumn = { bg = "#3c3836" },
        SignColumn = { bg = "#1d2021" },
        CursorLineNr = { fg = "#fe8019" },
      },
    })
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
