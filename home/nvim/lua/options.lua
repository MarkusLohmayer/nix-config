vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.undofile = true                         -- enable persistent undo

vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim

vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab

vim.opt.smartindent = true                      -- make indenting smarter again

vim.opt.signcolumn = "yes"                      -- always show the sign column

vim.opt.number = true                           -- set numbered lines
vim.opt.numberwidth = 4                         -- minimal number of columns to use for the line number {default 4}
vim.opt.relativenumber = true
vim.opt.cursorline = true                       -- highlight the current line

vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case

vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files

vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.timeout = true
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)

vim.opt.showtabline = 0                         -- always show tabs
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

vim.opt.iskeyword:append "-"                    -- treat words with `-` as single words

vim.g.markdown_folding = true
