-- Popup showing available keybindings after pressing <leader> (or another
-- prefix) and pausing, so the growing set of custom mappings stays
-- discoverable instead of memorized
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "Find (telescope)" },
      { "<leader>g", group = "Git/GitHub" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>t", group = "Tabs" },
      { "<leader>s", group = "Spelling" },
      { "<leader>x", group = "Diagnostics (trouble)" },
      { "<leader>u", group = "UI toggles" },
    },
  },
}
