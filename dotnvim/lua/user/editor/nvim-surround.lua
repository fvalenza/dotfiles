local opts_keymap = { silent = true }

local M = {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
}

function M.config()
  require("nvim-surround").setup({

  })
end

return M
