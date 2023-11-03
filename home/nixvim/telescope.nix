{helpers, ...}: {
  config = {
    plugins.telescope = {
      enable = true;
      extensions.frecency.enable = true;
      extensions.project-nvim.enable = true;
      extraOptions = {
        pickers.colorscheme.enable_preview = true;
      };
      defaults = {
        prompt_prefix = " ";
        selection_caret = "❯ ";
        path_display = [
          "truncate"
        ];
        sorting_strategy = "ascending";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
          };
          vertical = {
            mirror = false;
          };
          width = 0.87;
          height = 0.80;
          preview_cutoff = 120;
        };
      };
    };
    colorschemes.catppuccin.customHighlights = {
      TelescopeBorder = {
        fg = helpers.mkRaw "colors.mantle";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewBorder = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.green";
      };
      TelescopePromptBorder = {
        fg = helpers.mkRaw "colors.mantle";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptNormal = {
        fg = helpers.mkRaw "colors.text";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptPrefix = {
        fg = helpers.mkRaw "colors.red";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.red";
      };
      TelescopeResultsBorder = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeResultsNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeResultsTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
    };
    keymaps = [
      {
        options.desc = "resume previous search";
        key = "<leader>s<cr>";
        action = ''function() require("telescope.builtin").resume() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search files";
        key = "<leader>sf";
        action = ''function() require("telescope.builtin").find_files() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search (hidden) files";
        key = "<leader>sF";
        action = ''function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search words";
        key = "<leader>sw";
        action = ''function() require("telescope.builtin").live_grep() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search words (in hidden files)";
        key = "<leader>sW";
        action = ''
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end
        '';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search buffers";
        key = "<leader>sb";
        action = ''function() require("telescope.builtin").buffers() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search word under cursor";
        key = "<leader>sc";
        action = ''function() require("telescope.builtin").grep_string() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search Vim commands";
        key = "<leader>sC";
        action = ''function() require("telescope.builtin").commands() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search Vim keymaps";
        key = "<leader>sk";
        action = ''function() require("telescope.builtin").keymaps() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search Vim themes";
        key = "<leader>st";
        action = ''function() require("telescope.builtin").colorscheme { enable_preview = true } end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "search projects";
        key = "<leader>sp";
        action = "<cmd>Telescope projects<cr>";
        options.silent = true;
      }
      {
        options.desc = "find Git branches";
        key = "<leader>sb";
        action = ''function() require("telescope.builtin").git_branches() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "find Git commits";
        key = "<leader>sc";
        action = ''function() require("telescope.builtin").git_commits() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "Git status";
        key = "<leader>st";
        action = ''function() require("telescope.builtin").git_status() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "Search diagnostics";
        key = "<leader>sD";
        action = ''function() require("telescope.builtin").diagnostics() end'';
        lua = true;
        options.silent = true;
      }
      {
        options.desc = "Search symbols";
        key = "<leader>ss";
        action = ''function() require("telescope.builtin").lsp_document_symbols() end'';
        lua = true;
        options.silent = true;
      }
    ];
  };
}
