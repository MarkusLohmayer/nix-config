local M = {
  "nkakouros-original/numbers.nvim",
  commit = "d1f95879a4cdf339f59e6a2dc6aef26912cf554c",
  event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  require("numbers").setup {
    excluded_filetypes = {},
  }
end

return M
