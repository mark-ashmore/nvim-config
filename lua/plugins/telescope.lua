-- Modern fzf-equivalent fuzzy finder, replacing junegunn/fzf.vim
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.6,
          },
        },
        preview = {
          filetype_hook = function(_, _, opts)
            if opts.winid then
              vim.wo[opts.winid].number = true
              vim.wo[opts.winid].relativenumber = false
            end
            return true
          end,
        },
      },
    })
    pcall(telescope.load_extension, "fzf")
  end,
}
