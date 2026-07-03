-- Subtle vertical indent guides
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = { char = "│" },
    scope = { enabled = true },
    exclude = {
      filetypes = { "help", "dashboard", "NvimTree", "lazy", "mason", "notify" },
    },
  },
}
