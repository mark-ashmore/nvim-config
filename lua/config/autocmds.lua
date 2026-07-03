-- Briefly flash yanked text so it's visually obvious what got copied
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Restore cursor to last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Trim trailing whitespace on save for the same filetypes vimrc targeted
local trim_group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = trim_group,
  pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee", "*.lua" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
