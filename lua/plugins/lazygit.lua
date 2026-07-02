-- Full lazygit TUI in a floating window without leaving nvim, using the
-- lazygit binary already installed via install.sh
return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
