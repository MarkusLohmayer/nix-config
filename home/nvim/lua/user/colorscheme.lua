local M = {
  "catppuccin/nvim",
  commit = "3e91672945ae882098556cbade4f47987e6bae6b",
  lazy = false,    -- make sure we load this during startup if it is your main color scheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "catppuccin-mocha"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
