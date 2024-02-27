local opts_keymap = { silent = true }
local M = {
  'mbbill/undotree',
  opts = {},
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>u", '<cmd>UndotreeToggle<CR>', desc = "Undo Tree", mode = "n", opts_keymap },
  },
}

return M
