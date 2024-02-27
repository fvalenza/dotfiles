local opts_keymap = { silent = true }

local M = {
  "simrat39/symbols-outline.nvim",
  event = "VeryLazy",
  cmd = "SymbolsOutline",
  keys = {
    { "<leader>a", '<cmd>SymbolsOutline<CR>', desc = "Toggle symbols outline", mode = "n", opts_keymap },
  },
}

function M.config()
  require( "symbols-outline").setup()
end

return M
