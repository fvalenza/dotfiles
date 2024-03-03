local M = {
  'echasnovski/mini.cursorword',
  lazy = false,
}
function M.config()
    require('mini.cursorword').setup()
end

return M
