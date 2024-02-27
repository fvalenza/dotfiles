
local opts_keymap = { silent = true }

local M = {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  cmd = "IncRename",
  keys = {
    { "gR", 'function() return ":IncRename " .. vim.fn.expand("<cword>") end', desc = "Rename symbol under cursor", mode = "n", opts_keymap },
  },
}

function M.config()
  require("inc_rename").setup()
  require("noice").setup({
      presets = { inc_rename = true }
  })
end

return M
