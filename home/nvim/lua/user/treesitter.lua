local M = {
  "nvim-treesitter/nvim-treesitter",
  commit = "226c1475a46a2ef6d840af9caa0117a439465500",
  event = "BufReadPost",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      commit = "0bf8fbc2ca8f8cdb6efbd0a9e32740d7a991e4c3",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
      commit = "0568104bf8d0c3ab16395433fcc5c1638efc25d4",
    },
    {
      "mrjones2014/nvim-ts-rainbow",
      event = "VeryLazy",
      commit = "840039440e012ad798ef31349b93a5d4365023ff",
    },
  },
}
function M.config()
  local treesitter = require "nvim-treesitter"
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = { "bash", "julia", "latex", "lua", "markdown", "markdown_inline", "python", "toml", "yaml" },
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    autopairs = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "css", "julia", "python" },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return M
