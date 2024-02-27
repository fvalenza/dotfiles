-- TODO Not working ? or you can try https://github.com/mcauley-penney/tidy.nvim
local M = {
  'echasnovski/mini.trailspace',
  lazy = false,
}

function M.config()  
    require('mini.trailspace').setup()
end

return M
