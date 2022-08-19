require("sort").setup {
  -- List of delimiters, in descending order of priority, to automatically
  -- sort on.
  delimiters = {
    ',',
    '|',
    ';',
    ':',
    's', -- Space
    't'  -- Tab
   }
}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "gs", "<Cmd>Sort i<CR>", opts)
keymap("v", "gs", "<Esc><Cmd>Sort i<CR>", opts)

keymap("n", "gS", "<Cmd>Sort<CR>", opts)
keymap("v", "gS", "<Esc><Cmd>Sort<CR>", opts)
