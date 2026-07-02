local opt = vim.opt

-- General
opt.history = 500
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

-- UI
opt.scrolloff = 10
opt.wildmenu = true
opt.wildignore:append({ "*.o", "*~", "*.pyc", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store" })
opt.ruler = true
opt.cmdheight = 1
opt.hidden = true
opt.backspace = { "eol", "start", "indent" }
opt.whichwrap:append("<,>,h,l")
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.magic = true
opt.showmatch = true
opt.matchtime = 2
opt.errorbells = false
opt.visualbell = false
opt.foldcolumn = "1"

-- Line numbers (relative + absolute, like vimrc)
opt.relativenumber = true
opt.number = true

-- Highlight only the current line's number (CursorLineNr), not the whole
-- line, matching VS Code's editor.renderLineHighlight = "gutter"
opt.cursorline = true
opt.cursorlineopt = "number"

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- Files / backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- Text, tab, indent
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.linebreak = true
opt.autoindent = true
opt.smartindent = true
opt.textwidth = 80
opt.formatoptions:remove("t")
opt.formatoptions:append("q")
opt.wrap = false

-- Colorcolumn to mark the 89th column (matches VS Code's editor.rulers)
opt.colorcolumn = "89"

-- Splits
opt.splitright = true

-- Hide the `~` end-of-buffer filler lines
opt.fillchars:append({ eob = " " })

-- Misc parity with vimrc
opt.updatetime = 100
opt.showmode = false
opt.showcmd = false
opt.shortmess:append("F")
opt.mouse = "a"
opt.signcolumn = "yes"
opt.encoding = "utf-8"

-- Nerd Font icons for gutter diagnostics instead of the default E/W/I/H.
-- Written as \u{} escapes (not pasted raw glyphs) since raw PUA characters
-- silently turned into empty strings when this file was previously saved.
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{f057}", -- nf-fa-times_circle
      [vim.diagnostic.severity.WARN] = "\u{f071}", -- nf-fa-exclamation_triangle
      [vim.diagnostic.severity.INFO] = "\u{f05a}", -- nf-fa-info_circle
      [vim.diagnostic.severity.HINT] = "\u{f0eb}", -- nf-fa-lightbulb_o
    },
  },
})
