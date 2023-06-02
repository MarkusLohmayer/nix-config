local M = {
  "EvWilson/slimux.nvim",
  commit = "bd12bc865d5a70d6025a801df95996e954f9ac31",
  event = "VimEnter",
}

function M.config()
  local slimux = require "slimux"
  require("slimux").setup {
    target_socket = slimux.get_tmux_socket(),
    target_pane = string.format("{last}", slimux.get_tmux_window()),
  }
  Map("v", "<leader>r", ':lua require("slimux").send_highlighted_text()<CR>', "send selected text to tmux pane")
  Map("n", "<leader>r", ':lua require("slimux").send_paragraph_text()<CR>', "send paragraph to tmux pane")
end

return M
