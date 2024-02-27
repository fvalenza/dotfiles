-- barbar makes buffer and tabs behave the same (like "tabs" in VsCode/Sublime).
-- In case it is not installed,  these keybindings may be of interest if one want to play with tabs.

-- Keeping it here in case i want to really use original tab feature of neovim
-- keymap("n", "<leader>to", ":tabnew<CR>") -- open new tab ( barbar makes no dsictincition betwwen tabs and buffers)
-- keymap("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- keymap("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- keymap("n", "<C-q>", "<cmd>BufferClose<CR>", opts)

local M = {
    "romgrk/barbar.nvim",
    -- commit = "<hash>",
    event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    keys = {
        { "<S-l>", "<cmd>BufferNext<cr>", desc = "Goto Next Buffer", mode = "n", opts_keymap },
        { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Goto Previous Buffer", mode = "n", opts_keymap },
        { "<C-q>", "<cmd>BufferClose<cr>", desc = "Close current Buffer", mode = "n", opts_keymap },
    }
}

function M.config()
end


return M
