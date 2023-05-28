local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("user", {
  install = { colorscheme = { require("user.colorscheme").name } },
  defaults = {
    lazy = true,
    commit = "903f0fe542fc35b74f3c09494f9c175346dfa76d"
  },
  ui = { wrap = "true" }, -- pinned plugins, don't check for updates
  checker = { enabled = false },
  change_detection = { enabled = true },
  debug = false,
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", -- Plugin for editing compressed files.
        -- "matchit", -- What is it?
        --  "matchparen", -- Plugin for showing matching parens
         "netrwPlugin", -- Handles file transfers and remote directory listing across a network
         "tarPlugin", -- Plugin for browsing tar files
         "tohtml", -- Converting a syntax highlighted file to HTML
         "tutor", -- Teaching?
         "zipPlugin", -- Handles browsing zipfiles
      },
    },
  },
})
