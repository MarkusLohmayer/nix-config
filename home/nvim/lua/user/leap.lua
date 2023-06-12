local M = {
  "ggandor/leap.nvim",
  commit = "14b5a65190fe69388a8f59c695ed3394a10d6af8",
  event = "VimEnter",
}

function M.config()
  require('leap').add_default_mappings()
end

return M
