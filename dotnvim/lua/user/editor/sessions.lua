local M = {
    "natecraddock/sessions.nvim",
}

function M.config()
    require("sessions").setup {
        events = {
            "VimLeavePre",
            "WinEnter",
        },
        session_filepath = vim.fn.stdpath("data") .. "/sessions",
        absolute = true,
    }

end

return M
