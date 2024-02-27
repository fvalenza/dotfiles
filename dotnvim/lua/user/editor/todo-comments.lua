local opts_keymap = { silent = true }
local M = {
  'folke/todo-comments.nvim',
  opts = {},
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "TodoTrouble",
  },
  keys = {
    { "<leader>T", '<cmd>TodoTrouble<CR>', desc = "TODOs trouble", mode = "n", opts_keymap },
  },
}

return M
