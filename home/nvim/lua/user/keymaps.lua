local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --

-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)


-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- replace selection with default register without yanking replaced text
keymap("v", "p", '"_dP', opts)

-- deleting text
keymap("n", "x", '"_x', opts)
keymap("x", "x", '"_d', opts)
keymap("n", "XX", '"_dd', opts)

-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)






-- spell checker

-- ]s / [s (navigate spelling mistakes)
-- z=      (suggest corrections)
-- zg      (add word as good word)
-- zug     (undo adding as good word)

-- space us (US spelling) (default)
-- keymap("n", "<leader>us", ":setlocal spell spellang=en_us<CR>", opts)

-- space gb (British spelling)
-- keymap("n", "<leader>gb", ":setlocal spell spellang=en_gb<CR>", opts)

-- space de (German spelling)
-- keymap("n", "<leader>de", ":setlocal spell spellang=de_de<CR>", opts)

-- space es (Spanish spelling)
-- keymap("n", "<leader>es", ":setlocal spell spellang=es<CR>", opts)

-- ctrl l (try to correct last mistake based on first suggestion)
keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)


-- remove trailing white space
vim .cmd([[
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
  command! TrimWhitespace call TrimWhitespace()
]])
