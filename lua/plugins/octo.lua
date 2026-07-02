-- Review/comment on/merge GitHub PRs and manage issues as native nvim
-- buffers, using the same `gh` auth already set up for this machine
return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "GitHub PR list" },
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "GitHub issue list" },
  },
  opts = {},
}
