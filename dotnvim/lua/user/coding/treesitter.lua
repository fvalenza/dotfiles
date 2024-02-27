local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "c", "cpp", "rust", "cmake" },
    highlight = { enable = true },
    indent = { enable = true },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = '<CR>',
    --     scope_incremental = '<CR>',
    --     node_incremental = '<TAB>',
    --     node_decremental = '<S-TAB>',
    --   },
    -- },
  }
end

return M
