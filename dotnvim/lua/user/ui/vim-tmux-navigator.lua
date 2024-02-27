-- If no vim-tmux-navigator  is installed, map these keybind so that they works inside neovim windows only.

-- Better window navigation inside neovim in case tmux navigator not loaded... should i test require and define them only is nok ?
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)


local M = {
  "christoomey/vim-tmux-navigator",
  -- commit = "f5d970d4506f385b29534252d8c15a782fa53034",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", '<cmd>TmuxNavigateLeft<CR>', desc = "Navigate left pane/window", mode = "n", opts_keymap },
    { "<C-j>", '<cmd>TmuxNavigateDown<CR>', desc = "Navigate down pane/window", mode = "n", opts_keymap },
    { "<C-k>", '<cmd>TmuxNavigateUp<CR>', desc = "Navigate up pane/window", mode = "n", opts_keymap },
    { "<C-l>", '<cmd>TmuxNavigateRight<CR>', desc = "Navigate right pane/window", mode = "n", opts_keymap },
  },
}

return M
