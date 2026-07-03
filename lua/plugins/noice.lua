-- Centered floating cmdline (instead of the classic bottom-row cmdline),
-- plus nicer message/popupmenu rendering. Flip `enabled` to false below for
-- a hard disable if it ever misbehaves (no need to remove the plugin) --
-- at runtime `:Noice disable` / `:Noice enable` also toggles it without a
-- restart or config edit.
local enabled = true

return {
  "folke/noice.nvim",
  enabled = enabled,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  init = function()
    -- Required so the classic bottom cmdline doesn't leave an empty bar
    -- alongside the floating popup; harmless on its own if noice is
    -- disabled, but reverting to 1 keeps things exactly as before.
    vim.opt.cmdheight = enabled and 0 or 1
  end,
  opts = {
    cmdline = {
      view = "cmdline_popup",
    },
    views = {
      cmdline_popup = {
        position = { row = "50%", col = "50%" },
        size = { width = 60, height = "auto" },
      },
    },
    -- Route hover/signature-help through noice's renderer so `K` and
    -- signature help match the popup look instead of Neovim's plain
    -- default float, matching the gruvbox-themed borders elsewhere
    lsp = {
      progress = {
        -- LSP progress ($/progress, e.g. Pyright "Analyzing files") shows
        -- in the lualine LSP status component instead of as popup toasts
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true },
      signature = { enabled = true },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      -- Combines the cmdline popup and its completion menu into one
      -- aligned block, the common "command palette" look
      command_palette = true,
      -- Consistent bordered floats for LSP hover/signature-help docs
      lsp_doc_border = true,
    },
  },
}
