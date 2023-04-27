function Map(mode, lhs, rhs, desc)
  local options = { silent = true, desc = desc}
  vim.keymap.set(mode, lhs, rhs, options)
end

--Remap space as leader key
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- Resize panes
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Buffers
Map("n", "<S-h>", ":bprevious<CR>", "previous buffer")
Map("n", "<S-l>", ":bnext<CR>", "next buffer")
Map("n", "<S-q>", "<cmd>Bdelete!<CR>", "close buffer")

-- Clear highlights
Map("n", "<leader>h", "<cmd>nohlsearch<CR>", "clear highlights")


-- Replace selection with default register without yanking replaced text
Map("v", "p", '"_dP')

-- Deleting text
Map("n", "x", '"_x')
Map("x", "x", '"_d')
Map("n", "XX", '"_dd')


-- Stay in visual mode when changing indentation
Map("v", "<", "<gv")
Map("v", ">", ">gv")


-- Spell checker
-- ]s / [s (navigate spelling mistakes)
-- z=      (suggest corrections)
-- zg      (add word as good word)
-- zug     (undo adding as good word)
Map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", "correct last typo")


-- Plugins --

-- NvimTree
Map("n", "<leader>e", ":NvimTreeToggle<CR>", "file explorer")

-- Telescope
Map("n", "<leader>ff", ":Telescope find_files<CR>", "find files")
Map("n", "<leader>ft", ":Telescope live_grep<CR>", "live grep")
Map("n", "<leader>fp", ":Telescope projects<CR>", "find projects")
Map("n", "<leader>fb", ":Telescope buffers<CR>", "find buffers")


-- Comment
Map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "toggle comment")
Map("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment")

-- Lsp
Map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "format buffer")



-- Remove trailing white space
vim.cmd [[
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
  command! TrimWhitespace call TrimWhitespace()
]]
