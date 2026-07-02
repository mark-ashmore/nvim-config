-- In-buffer rendering (headings, checkboxes, bold/italic), matching the
-- editing experience from VS Code's yzhang.markdown-all-in-one
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
}
