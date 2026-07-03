-- Mode-colored statusline, mirroring the vim.statusBarColors set in VS Code
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = {
      bg = "#1d2021",
      normal = "#928374",
      insert = "#458588",
      visual = "#d65d0e",
      visual_block = "#fe8019",
      replace = "#8ec07c",
      command = "#a89984",
      fg = "#1d2021",
    }

    local mode_color = function()
      local mode_colors = {
        n = colors.normal,
        i = colors.insert,
        v = colors.visual,
        [""] = colors.visual_block,
        V = colors.visual_block,
        c = colors.command,
        R = colors.replace,
      }
      return { bg = mode_colors[vim.fn.mode()] or colors.normal, fg = colors.fg }
    end

    require("lualine").setup({
      options = {
        theme = "gruvbox",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", color = mode_color } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          -- LSP progress (e.g. Pyright "Analyzing files"), quieter than
          -- noice's popup toasts; blank when nothing is in progress
          { function() return vim.lsp.status() end },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
