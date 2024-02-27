
-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 500 }
  end,
})



-- Highlight trailing whitespace for all files except Markdown
-- vim.cmd([[
--   augroup TrailingWhitespace
--     autocmd!
--     autocmd BufWinEnter,WinEnter * if &filetype !=# 'markdown' | highlight link ExtraWhitespace Error | match ExtraWhitespace /\s\+$/ | endif
--     autocmd InsertEnter * match ExtraWhitespace /\s\+$/
--     autocmd InsertLeave * match ExtraWhitespace /\s\+$/
--   augroup END
-- ]])
