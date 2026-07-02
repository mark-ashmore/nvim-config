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
        -- gruvbox's *Sign highlight groups default to bg1 (#3c3836), which
        -- doesn't match SignColumn's darker bg above; drop the bg so the
        -- cursor line number and diagnostic gutter icons blend in instead
        -- of showing a lighter grey box behind them
        CursorLineNr = { fg = "#fe8019", bg = "NONE" },
        DiagnosticSignError = { fg = "#fb4934", bg = "NONE" },
        DiagnosticSignWarn = { fg = "#fabd2f", bg = "NONE" },
        DiagnosticSignInfo = { fg = "#83a598", bg = "NONE" },
        DiagnosticSignHint = { fg = "#8ec07c", bg = "NONE" },
      },
    })
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
