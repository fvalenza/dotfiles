-- File Handling
vim.opt.backup = false                       -- creates a backup file
vim.opt.swapfile = false                     -- creates a swapfile
vim.opt.undofile = true                      -- enable persistent undo
vim.opt.writebackup = false                  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.fileencoding = "utf-8"               -- the encoding written to a file

-- Search and Highlighting
vim.opt.ignorecase = true                    -- ignore case in search patterns
vim.opt.smartcase = true                     -- smart case: override ignorecase if the search pattern contains uppercase characters
vim.opt.incsearch = true                     -- incrementally highlight search matches as you type the search pattern
vim.opt.hlsearch = true                      -- highlight all matches on the previous search pattern

-- Interface
vim.opt.showmode = false                     -- hide (partial) command in the last line of the screen (for performance)
vim.opt.laststatus = 3                       -- always display the status line in the last window
vim.opt.showcmd = false                      -- hide display of incomplete commands in the last line of the screen (for performance)
vim.opt.ruler = false                        -- hide the line and column number of the cursor position
vim.opt.number = true                        -- display line numbers
vim.opt.relativenumber = true                -- display relative line numbers
vim.opt.cursorline = true                    -- highlight the current line
vim.opt.signcolumn = "yes"                   -- always show the sign column; otherwise, it would shift the text each time
vim.opt.colorcolumn = "120"                  -- display a vertical line at column 120

-- Indentation and Formatting
vim.opt.tabstop = 4                          -- insert 4 spaces for a tab
vim.opt.softtabstop = 4                      -- insert 4 spaces for a tab
vim.opt.shiftwidth = 4                       -- the number of spaces inserted for each indentation
vim.opt.expandtab = true                     -- convert tabs to spaces
vim.opt.breakindent = true                   -- wrapped lines start with the same indent
vim.opt.smartindent = true                   -- make indenting smarter
vim.opt.linebreak = true                     -- wrap lines at convenient points without breaking words
vim.opt.formatoptions = 'qjl1'               -- don't autoformat comments, and other specified options (You can adjust this value based on your preferences)
-- vim.opt.foldmethod = "expr"                  -- use the expression provided by 'foldexpr' to determine folds
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- use nvim-treesitter to determine folds
vim.opt.backspace = "indent,eol,start"       -- allow backspacing over autoindent, line breaks, and the start of insertions
vim.opt.virtualedit = 'block'                -- allow going past the end of the line in visual block mode

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }  -- completion options for the popup menu (Add "noinsert" here if desired)
vim.opt.shortmess:append "c"                 -- hide all the completion messages, e.g., "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append "<,>,[,],h,l"       -- allow moving to the previous/next line when the beginning/end of the line is reached
vim.opt.iskeyword:append("-")                -- treats words with `-` as a single word

-- Interface and Display
vim.g.netrw_banner = 0
vim.opt.cmdheight = 1                        -- more space in the Neovim command line for displaying messages
vim.opt.pumheight = 10                       -- popup menu height
vim.opt.showtabline = 0                      -- always show the tabs
vim.opt.timeout = true                       -- enable mapping timeout
vim.opt.timeoutlen = 300                     -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 100                     -- time (in milliseconds) to wait for events to trigger, used to speed up completion
vim.opt.numberwidth = 4                      -- minimal number of columns to use for the line number (default 4)
vim.opt.wrap = false                         -- display lines as one long line
vim.opt.scrolloff = 15                       -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                    -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.guifont = "monospace:h17"            -- the font used in graphical Neovim applications
vim.opt.fillchars.eob = " "                  -- show empty lines at the end of a buffer as ` ` (default `~`)

-- Other Settings
vim.opt.termguicolors = true                 -- set terminal GUI colors (most terminals support this)
vim.opt.conceallevel = 0                     -- so that `` is visible in markdown files
vim.opt.splitbelow = true                    -- force all horizontal splits to go below current window
vim.opt.splitright = true                    -- force all vertical splits to go to the right of current window


-- Additional Settings (Uncategorized)
vim.opt.mouse = "a"                          -- allow the mouse to be used in Neovim
vim.opt.isfname:append("@-@")                -- add '@' and '-' as valid characters for a filename

-- If you decide to enable system clipboard support, uncomment the following line:
-- vim.opt.clipboard = "unnamedplus"            -- allows Neovim to access the system clipboard
