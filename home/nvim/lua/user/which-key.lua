local M = {
  "folke/which-key.nvim",
  commit = "5224c261825263f46f6771f1b644cae33cd06995",
  event = "VeryLazy",
}

function M.config()
  require("which-key").setup {
    window = {
      border = "single",
    },
  }
end

return M
