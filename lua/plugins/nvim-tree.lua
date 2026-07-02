-- Sidebar file explorer with gruvbox-tinted icon colors, akin to the
-- material-icon-theme + colored sidebar setup in VS Code
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
  },
  opts = {
    view = { width = 32 },
    renderer = {
      highlight_git = true,
      icons = { show = { git = true } },
    },
    filters = { dotfiles = false },
  },
}
