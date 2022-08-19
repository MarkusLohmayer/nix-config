
vim.g.slime_target = "tmux"
-- vim.g.slime_default_config = '{"socket_name": "default", "target_pane": "{last}"}'
vim.cmd  'let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}'
vim.g.slime_no_mappings = 1
vim.g.slime_dont_ask_default = 1

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>r", ":SlimeSend<CR>", opts)
keymap("x", "<leader>r", ":SlimeSend<CR>", opts)
