local M = {
  "numToStr/Comment.nvim",
  commit = "eab2c83a0207369900e92783f56990808082eac2",
  event = {"BufRead", "BufNewFile"},
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      commit = "a0f89563ba36b3bacd62cf967b46beb4c2c29e52",
    },
  },
}

return M
