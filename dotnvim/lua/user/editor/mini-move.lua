-- Made it work thanks to https://github.com/alpha2phi/modern-neovim/blob/12-ai/lua/plugins/mini.lua
-- mini.move allows not to manually map: (and more with alt-h/l)
-- 
-- -- Move text up and down
-- keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts) -- To remove if can get mini.move working
-- keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts) -- To remove if can get mini.move working
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts) -- To remove if can get mini.move working
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts) -- To remove if can get mini.move working
-- keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts) -- To remove if can get mini.move working
-- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts) -- To remove if can get mini.move working

local opts_keymap = { silent = true }

local M = {
  "echasnovski/mini.move",
  keys = { "<<M-h>", "<M-l>", "<M-j>", "<M-k>" },
}

function M.config()
  require('mini.move').setup()
end


return M
