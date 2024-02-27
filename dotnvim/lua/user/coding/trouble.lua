local opts_keymap = { silent = true }

local M = {
  "folke/trouble.nvim",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
  keys = {
    { "<leader>xx", '<cmd>TroubleToggle<CR>', desc = "TroubleToggle", mode = "n", opts_keymap },
    { "<leader>xw", '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = "TroubleToggle workspace_diagnostics", mode = "n", opts_keymap },
    { "<leader>xd", '<cmd>TroubleToggle document_diagnostics<CR>', desc = "TroubleToggle document_diagnostics", mode = "n", opts_keymap },
    { "<leader>xl", '<cmd>TroubleToggle loclist<CR>', desc = "TroubleToggle loclist", mode = "n", opts_keymap },
    { "<leader>xq", '<cmd>TroubleToggle quickfix<CR>', desc = "TroubleToggle quickfix", mode = "n", opts_keymap },
    { "<leader>gR", '<cmd>TroubleToggle lsp_references<CR>', desc = "TroubleToggle lsp_references", mode = "n", opts_keymap }, -- push in jumplist but not tagstack
  },
}

function M.config()
  require( "trouble").setup({
    icons = false,
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  })
end

return M
