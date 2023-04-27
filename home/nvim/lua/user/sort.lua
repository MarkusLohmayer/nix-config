local M = {
  "sQVe/sort.nvim",
  commit = "c789da6968337d2a61104a929880b5f144e02855",
  event = "VeryLazy",
}

function M.config()
  require("sort").setup {
    -- List of delimiters, in descending order of priority, to automatically sort on.
    delimiters = {
      ",",
      "|",
      ";",
      ":",
      "s", -- Space
      "t", -- Tab
    },
  }
end


Map("n", "gs", "<Cmd>Sort i<CR>", "sort (case-insensitive)")
Map("v", "gs", "<Esc><Cmd>Sort i<CR>", "sort (case-insensitive)")

Map("n", "gS", "<Cmd>Sort<CR>", "sort (case-sensitive)")
Map("v", "gS", "<Esc><Cmd>Sort<CR>", "sort (case-sensitive)")

return M
