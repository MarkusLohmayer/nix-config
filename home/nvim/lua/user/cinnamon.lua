local M = {
  -- smooth scrolling for any movement command
  "declancm/cinnamon.nvim",
  commit = "c406ffda3a0302f32c23b24ab756ea20467d6578",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  require("cinnamon").setup {
    default_keymaps = true,
    extra_keymaps = true,
    extended_keymaps = true,
    always_scroll = true,
    centered = true,
  }
end

return M
