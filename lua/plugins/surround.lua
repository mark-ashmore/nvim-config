-- Add/change/delete surrounding quotes/brackets: ys{motion}{char},
-- cs{old}{new}, ds{char} (e.g. ysiw" to wrap a word in quotes)
return {
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
}
