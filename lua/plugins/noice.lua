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
    presets = {
      bottom_search = true,
      long_message_to_split = true,
    },
  },
}
