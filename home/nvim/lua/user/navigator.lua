require('Navigator').setup {
    -- When you want to save the modified buffers when moving to tmux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when tmux is zoomed in
    disable_on_zoom = false
}


local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', "<A-h>", '<CMD>NavigatorLeft<CR>', opts)
keymap('n', "<A-l>", '<CMD>NavigatorRight<CR>', opts)
keymap('n', "<A-k>", '<CMD>NavigatorUp<CR>', opts)
keymap('n', "<A-j>", '<CMD>NavigatorDown<CR>', opts)
keymap('n', "<A-p>", '<CMD>NavigatorPrevious<CR>', opts)
