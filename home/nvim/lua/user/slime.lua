local M = {
  "jpalardy/vim-slime",
  commit = "bb152854fc21193729bf587aa055e738d50c8b48",
  event = "VimEnter",
}

vim.g.slime_target = "tmux"
vim.g.slime_default_config = {socket_name = "default", target_pane = "{last}"}
vim.g.slime_no_mappings = 1
vim.g.slime_dont_ask_default = 1

Map("n", "<leader>r", ":SlimeSend<CR>", "send text to tmux pane")
Map("x", "<leader>r", ":SlimeSend<CR>", "send text to tmux pane")

return M
