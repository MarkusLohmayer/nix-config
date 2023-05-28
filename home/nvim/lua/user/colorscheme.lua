local M = {
  "catppuccin/nvim",
  commit = "3e91672945ae882098556cbade4f47987e6bae6b",
  lazy = false,    -- make sure we load this during startup if it is your main color scheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "catppuccin"

function M.config()
  require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.25,
    },
    custom_highlights = function(colors)
      return {
          Comment = { fg = colors.flamingo },
          WinSeparator = { fg = colors.flamingo }
      }
    end,
  })
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
