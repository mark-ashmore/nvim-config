return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Gclog", "Gblame" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
  },
}
