vim.g.mapleader = ","

local map = vim.keymap.set

-- Fast saving
map("n", "<leader>w", ":w!<cr>")

-- Space to search, like vimrc's map <space> /
map("n", "<space>", "/")
map("n", "<C-space>", "?")

-- Clear search highlight
map("n", "<leader><cr>", ":noh<cr>", { silent = true })

-- Window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Buffer management
map("n", "<leader>bd", ":bdelete<cr>")
map("n", "<leader>ba", ":bufdo bd<cr>")
map("n", "<leader>l", ":bnext<cr>")
map("n", "<leader>h", ":bprevious<cr>")

-- Tabs
map("n", "<leader>tn", ":tabnew<cr>")
map("n", "<leader>to", ":tabonly<cr>")
map("n", "<leader>tc", ":tabclose<cr>")
map("n", "<leader>tm", ":tabmove")
map("n", "<leader>t<leader>", ":tabnext")

-- Switch CWD to the directory of the open buffer
map("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")

-- Remap 0 to first non-blank character
map("n", "0", "^")

-- Move lines with Alt/Cmd+j/k
map("n", "<M-j>", ":m .+1<cr>==")
map("n", "<M-k>", ":m .-2<cr>==")
map("v", "<M-j>", ":m '>+1<cr>gv=gv")
map("v", "<M-k>", ":m '<-2<cr>gv=gv")
map("n", "<D-j>", ":m .+1<cr>==")
map("n", "<D-k>", ":m .-2<cr>==")
map("v", "<D-j>", ":m '>+1<cr>gv=gv")
map("v", "<D-k>", ":m '<-2<cr>gv=gv")

-- Spell check toggle
map("n", "<leader>ss", ":setlocal spell!<cr>")
map("n", "<leader>sn", "]s")
map("n", "<leader>sp", "[s")
map("n", "<leader>sa", "zg")
map("n", "<leader>s?", "z=")

-- Scratch buffers
map("n", "<leader>q", ":e ~/buffer<cr>")
map("n", "<leader>x", ":e ~/buffer.md<cr>")

-- Toggle paste mode
map("n", "<leader>pp", ":setlocal paste!<cr>")

-- Sort a JSON buffer/selection by key, matching richie5um2.vscode-sort-json
map("n", "<leader>js", ":%!jq -S .<cr>", { desc = "Sort JSON buffer" })
map("v", "<leader>js", ":!jq -S .<cr>", { desc = "Sort JSON selection" })

-- Escape terminal mode like a normal Esc, instead of <C-\><C-n>
map("t", "<Esc>", "<C-\\><C-n>")

-- Open a terminal in a bottom split, like vimrc's `cabbrev bterm bo term`
vim.api.nvim_create_user_command("Bterm", "botright terminal", {})
vim.cmd("cabbrev bterm Bterm")

-- Reload options/keymaps/autocmds without restarting nvim. Only covers
-- lua/config/*.lua (plain vim.opt/keymap/autocmd scripts); plugin changes
-- under lua/plugins/*.lua need `:Lazy reload <plugin-name>` instead, since
-- lazy.nvim tracks each plugin's own loaded/config state separately.
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^config%.") then
      package.loaded[name] = nil
    end
  end
  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
  vim.notify("Reloaded config.options / config.keymaps / config.autocmds")
end, { desc = "Reload lua/config/*.lua without restarting nvim" })
