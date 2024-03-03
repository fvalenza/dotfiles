local M = {
    "folke/twilight.nvim",

    keys = {
        { "<leader>tw", '<cmd>Twilight<CR>', desc = "Toggle Twilight", mode = "n", opts_keymap },
    },
}

function M.config()
    require("twilight").setup {
    }
end

return M
