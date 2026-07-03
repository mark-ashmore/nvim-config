-- Auto-close brackets/quotes as you type, replacing the old vimrc's
-- manual $1/$2/$3/$q/$e insert-mode mappings
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
