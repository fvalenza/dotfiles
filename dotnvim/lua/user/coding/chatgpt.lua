-- https://www.youtube.com/watch?v=7k0KZsheLP4
-- The secret API key should be either exported as OPENAI_API_KEY variable or added here within api_key_cmd
local opts_keymap = { silent = true }
local M = {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",

  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}


function M.config()
  require("chatgpt").setup({
    -- api_key_cmd = "command to get the key",
  })
end


return M
