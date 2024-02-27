local opts_keymap = { silent = true }
local M = {
  'danymat/neogen',
  opts = {},
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     {
      "L3MON4D3/LuaSnip",
      commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
        commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
      },
    },
  },
  cmd = { "Neogen" },
}


function M.config()
  require("neogen").setup({
    snippet_engine = "luasnip",
  })
end


return M

