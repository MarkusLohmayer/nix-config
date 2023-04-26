local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local normal_mode = "n"
local insert_mode = "i"
local visual_mode = "v"
local visual_block_mode = "x"
local term_mode = "t"
local command_mode = "c"

-- keep cursor centered while moving half page up/down
keymap(normal_mode, "<C-u>", "<C-u>zz", opts)
keymap(normal_mode, "<C-d>", "<C-d>zz", opts)

-- Better window navigation
-- keymap(normal_mode, "<C-h>", "<C-w>h", opts)
-- keymap(normal_mode, "<C-j>", "<C-w>j", opts)
-- keymap(normal_mode, "<C-k>", "<C-w>k", opts)
-- keymap(normal_mode, "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap(normal_mode, "<C-Up>", ":resize +2<CR>", opts)
-- keymap(normal_mode, "<C-Down>", ":resize -2<CR>", opts)
-- keymap(normal_mode, "<C-Left>", ":vertical resize +2<CR>", opts)
-- keymap(normal_mode, "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap(normal_mode, "<S-l>", ":bnext<CR>", opts)
keymap(normal_mode, "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap(normal_mode, "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap(normal_mode, "<A-k>", "<Esc>:m .-2<CR>==gi", opts)


-- Press jk fast to enter normal mode
-- keymap(insert_mode, "jk", "<ESC>", opts)


-- Stay in indent mode
keymap(visual_mode, "<", "<gv", opts)
keymap(visual_mode, ">", ">gv", opts)

-- Move text up and down
-- keymap(visual_mode, "<A-j>", ":m .+1<CR>==", opts)
-- keymap(visual_mode, "<A-k>", ":m .-2<CR>==", opts)

-- replace selection with default register without yanking replaced text
keymap(visual_mode, "p", '"_dP', opts)

-- deleting text
keymap(normal_mode, "x", '"_x', opts)
keymap(visual_block_mode, "x", '"_d', opts)
keymap(normal_mode, "XX", '"_dd', opts)


-- Move text up and down
keymap(visual_block_mode, "J", ":move '>+1<CR>gv-gv", opts)
keymap(visual_block_mode, "K", ":move '<-2<CR>gv-gv", opts)
-- keymap(visual_block_mode, "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap(visual_block_mode, "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Better terminal navigation
-- keymap(term_mode, "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap(term_mode, "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap(term_mode, "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap(term_mode, "<C-l>", "<C-\\><C-N><C-w>l", term_opts)




-- spell checker

-- ]s / [s (navigate spelling mistakes)
-- z=      (suggest corrections)
-- zg      (add word as good word)
-- zug     (undo adding as good word)

-- space us (US spelling) (default)
-- keymap(normal_mode, "<leader>us", ":setlocal spell spellang=en_us<CR>", opts)

-- space gb (British spelling)
-- keymap(normal_mode, "<leader>gb", ":setlocal spell spellang=en_gb<CR>", opts)

-- space de (German spelling)
-- keymap(normal_mode, "<leader>de", ":setlocal spell spellang=de_de<CR>", opts)

-- space es (Spanish spelling)
-- keymap(normal_mode, "<leader>es", ":setlocal spell spellang=es<CR>", opts)

-- ctrl l (try to correct last mistake based on first suggestion)
keymap(insert_mode, "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)


-- remove trailing white space
vim .cmd([[
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
  command! TrimWhitespace call TrimWhitespace()
]])
