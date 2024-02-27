-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- For mapping ctrl-shift-key in alacritty
-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/


local keymap = vim.keymap.set -- Shorten function name
local opts = { silent = true } -- Silent keymap option

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", ":nohl<CR>:echo<CR>")

keymap("n", "Q", "<nop>")

-- From insert to normal mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

keymap("n", "<leader>q", "<cmd>q<cr>")
keymap("n", "<C-a>", "gg<S-v>G")

-- Better mapping to go to start/end of line 
keymap("n", "H", "^")
keymap("n", "L", "$")

-- Alternativernative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
keymap(  'n',        '<C-S>', '<Cmd>silent! update | redraw<CR>',      { desc = 'Save' })
keymap({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })


keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts) -- Keep the current selection when (de)-indenting in Visual mode (Stay in indent mode)

keymap("n", "<C-S-d>", ":t.<CR>", opts) -- duplicate line under cursor ala Sublime
keymap("v", "<", "<gv", opts) -- Keep the current selection when (de)-indenting in Visual mode (Stay in indent mode)
keymap("v", ">", ">gv", opts) -- Keep the current selection when (de)-indenting in Visual mode (Stay in indent mode)

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") --  C-f pour switch de ssion tmux ?

------------------------------------------------------------------------------------------
--                               Window/Buffer Management                               --
------------------------------------------------------------------------------------------
keymap("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>") -- close current split window

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)  -- Make the window bigger top-down
keymap("n", "<C-Down>", ":resize -2<CR>", opts) -- Make the window smaller top-down
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts) -- Make the window smaller left-right
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts) -- Make the window bigger left-right


-- Centering cursor when moving in buffer
keymap("n", "<C-d>", "<C-d>zz") -- cursor stays in the middle of screen when moving half page down
keymap("n", "<C-u>", "<C-u>zz") -- cursor stays in the middle of screen when moving half page up
keymap("n", "n", "nzzzv") -- cursor stays in the middle of screen when going to next find result of search
keymap("n", "N", "Nzzzv") -- cursor stays in the middle of screen when going to previous find result of search

keymap("n", "<tab>", "<cmd>tabNext<CR>") -- cursor stays in the middle of screen when going to previous find result of search
keymap("n", "<S-tab>", "<cmd>tabprevious<CR>") -- cursor stays in the middle of screen when going to previous find result of search
keymap("n", "<leader><tab>", "<cmd>tabnew<CR>") -- cursor stays in the middle of screen when going to previous find result of search
keymap("n", "<leader><S-tab>", "<cmd>tabclose<CR>") -- cursor stays in the middle of screen when going to previous find result of search
------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------
--                                    NVoidIM                                           --
------------------------------------------------------------------------------------------
-- Mapping to send into the void (black hole register) when changing/deleting
-- alt = from cursor till begining of line
-- shift = from cursor till end of line

-- 'c' changes but does not yank
keymap('n', '<leader><A-c>', '"_c0', { noremap = true })
keymap('n', '<leader><S-c>', '"_C', { noremap = true })
keymap({'n','v'}, '<leader>c', '"_c', { noremap = true })
keymap('n', '<leader>cc', '"_cc', { noremap = true })

-- 'd' yanks unless empty line[n]/lines[v]
keymap('n', '<leader><A-d>', '"_d0', { noremap = true })
keymap('n', '<leader><S-d>', '"_D', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', '"_dd', { noremap = true }) -- d yanks unless empty line ( black hole). Same for dd
vim.keymap.set("v", "d", function ()
    local lines = vim.fn.getline("'<", "'>")
    for _, line in ipairs(lines) do
        if line:match("^%s*$") == nil then -- Check if the line contains non-whitespace characters
            return "d"
        end
    end
    return '"_d' -- All lines are empty or contain only spaces, delete to black hole register
end, {expr = true})

vim.keymap.set("n", "dd", function ()
    if vim.fn.getline(".") == "" then return '"_dd' end -- if empty line, dd to black hole register
    return "dd"
end, {expr = true})



-- 'x' deletes but does not yank
keymap({'n','v'}, 'x', '"_x', { noremap = true })
keymap('n', 'X', '"_X', { noremap = true })

------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------
--                                 YANK / PASTE                                         --
------------------------------------------------------------------------------------------
keymap('n', '<A-c>', 'c0', { noremap = true })
-- keymap('n', '<S-c>', 'C', { noremap = true }) -- redundant
keymap('n', '<A-d>', 'd0', { noremap = true })
-- keymap('n', '<S-d>', 'D', { noremap = true }) -- redundant
keymap('n', '<A-y>', 'y0', { noremap = true })
keymap('n', '<S-y>', 'y$', { noremap = true })
keymap("x", "p", [["_dP]]) -- overwrite current selection whit current yank without touching register (= delete selection into void register and Paste  ( so you can still copy the same word))
keymap("v", "p", "P", opts) -- better paste


--  Copy to system clipboard
--  If you want by default share every yank/paste with system, use vim.opt.clipboard = "unamedplus"
--  and remove these keympas
keymap({"n", "v"}, "<leader>y", [["+y]]) -- yank with motion[n]/selection[v]. Note: the second y in 'yy' is the motion.
keymap("n", "<leader>Y", [["+Y]]) -- yank til end of line (same as yg_)

keymap({"n", "v"}, "<leader>p", [["+p]])
keymap({"n", "v"}, "<leader>P", [["+P]])
------------------------------------------------------------------------------------------
-- Reselect latest changed, put, or yanked text
-- map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })


------------------------------------------------------------------------------------------
--                                 TEXT REPLACEMENT                                     --
------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) --  Pour remplacer tous les mots du buffer comme celui sous le curseur

-- VIM way for multi cursor (ctrl-d ala sublime)
-- Replace current word[n]/selection[v] and allow replay the change with dot to next occurence.(skippable with n)
keymap("n", "c*", [[*Ncgn]], opts)
keymap('v', '/', "\"fy/\\V<C-R>f<CR>N" ) -- Same as *N but with current selection in visual mode
keymap('v', '<leader>/', "\"fy/\\V<C-R>f<CR>Ncgn" ) -- Same as *Ncgn but with current selection in visual mode

vim.api.nvim_set_keymap('n', 'c.', '/\\V\\C<C-r>"<CR>cgn<C-a><Esc>', { noremap = true }) -- https://www.reddit.com/r/neovim/comments/sf0hmc/im_really_proud_of_this_mapping_i_came_up_with/
                                                                                         -- Only work if c is not remaped to black hole.


------------------------------------------------------------------------------------------

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts) -- should open repo in smerge ? or have all methods in sublime text -> merge ? at least open repo + File history is nice to have
