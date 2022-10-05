local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
		}
		print "Installing packer close and reopen Neovim..."
		vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim when plugins.lua file is written
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- install your plugins here
return packer.startup(function(use)
  -- have packer manage itself
	use "wbthomason/packer.nvim"

  -- an implementation of the popup API from vim in Neovim
	use "nvim-lua/popup.nvim"

  -- Useful lua functions used by lots of plugins
	use "nvim-lua/plenary.nvim"

  -- autopairs, integrates with both cmp and treesitter
	-- use "windwp/nvim-autopairs"

  -- easily comment stuff
	use "numToStr/Comment.nvim"

  -- file explorer
	use {
			'kyazdani42/nvim-tree.lua',
			requires = {
				'kyazdani42/nvim-web-devicons', -- optional, for file icon
			},
			-- tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

  -- tabs similar to GUI editors
	use "akinsho/bufferline.nvim"

  -- close buffer
	use "moll/vim-bbye"

  -- statusline
	use "nvim-lualine/lualine.nvim"

  -- manage terminal windows
	use "akinsho/toggleterm.nvim"

  -- project management
	use "ahmedkhalf/project.nvim"

  -- improve startup time
	use "lewis6991/impatient.nvim"

  -- indentation guides
	use "lukas-reineke/indent-blankline.nvim"

  -- greeter
	-- use "goolord/alpha-nvim"

  -- this is needed to fix lsp doc highlight
	use "antoinemadec/FixCursorHold.nvim"

  -- show keymaps
	use "folke/which-key.nvim"

  -- relative line numbers only where they make sense
	use "nkakouros-original/numbers.nvim"

  -- send text to tmux
  use "jpalardy/vim-slime"

  -- create directory on save if it does not exist
	use "jghauser/mkdir.nvim"

  -- surround text object
	use "ur4ltz/surround.nvim"

	-- https://editorconfig.org
	-- supported by PyCharm, VisualStudio, GitHub, GitLab, ...
	-- plugins for VS Code, Sublime, Emacs, Notepad++, gedit, ...
  use "gpanders/editorconfig.nvim"

  -- smoothly navigate between neovim splits and tmux panes
  use "numToStr/Navigator.nvim"

	use "sQVe/sort.nvim"

  use "chentoast/marks.nvim"

	use "lervag/vimtex"

	-- color scheme
	use "lunarvim/darkplus.nvim"

	-- nvim-cmp completion plugin
	use "hrsh7th/nvim-cmp"

  -- complete words from buffer
	use "hrsh7th/cmp-buffer"

  -- complete paths
	use "hrsh7th/cmp-path"

  -- completions for command mode and search
	use "hrsh7th/cmp-cmdline"

  -- completion for snippets
	use "saadparwaiz1/cmp_luasnip"

  -- completions from built-in language server client
	use "hrsh7th/cmp-nvim-lsp"

  -- completion for Unicode symbols based on LaTeX command
	use "kdheepak/cmp-latex-symbols"

  --snippet engine
	use "L3MON4D3/LuaSnip"

  -- a bunch of snippets to use
	use "rafamadriz/friendly-snippets"

  -- language server configurations
	use "neovim/nvim-lspconfig"

  -- manage language servers with `:LspInstall`
	use "williamboman/nvim-lsp-installer"

  -- language server settings defined in json/yaml
	use "tamago324/nlsp-settings.nvim"

  -- for formatters and linters
	use "jose-elias-alvarez/null-ls.nvim"

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}

  -- use treesitter to set the comment string depending on cursor position
	use "JoosepAlviste/nvim-ts-context-commentstring"

  -- use treesitter for rainbow parenthesis
	use "p00f/nvim-ts-rainbow"

  -- use treesitter for spell checking
	use {
		'lewis6991/spellsitter.nvim',
		config = function()
			require('spellsitter').setup()
		end
	}

	-- Git integration
	use "lewis6991/gitsigns.nvim"


	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
