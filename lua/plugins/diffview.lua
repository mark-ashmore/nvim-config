-- Git history/diff browsing, matching VS Code's mhutchie.git-graph
-- (pair with `lazygit` in a terminal for the full interactive graph)
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history (git graph)" },
  },
}
