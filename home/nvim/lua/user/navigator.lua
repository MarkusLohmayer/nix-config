local M = {
  "numToStr/Navigator.nvim",
  commit = "91d86506ac2a039504d5205d32a1d4bc7aa57072",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  local navigator = require "Navigator"
  navigator.setup()
end

Map({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>", "move left")
Map({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>", "move down")
Map({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>", "move up")
Map({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>", "move right")

return M
