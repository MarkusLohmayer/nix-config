{...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions.frecency.enable = true;
      settings = {
        pickers.colorscheme.enable_preview = true;
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
    };

    keymaps = [
      {
        options.desc = "resume previous search";
        key = "<leader>s<cr>";
        action.__raw = ''function() require("telescope.builtin").resume() end'';
        options.silent = true;
      }
      {
        options.desc = "search files";
        key = "<leader>sf";
        action.__raw = ''function() require("telescope.builtin").find_files() end'';
        options.silent = true;
      }
      {
        options.desc = "search (hidden) files";
        key = "<leader>sF";
        action.__raw = ''function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end'';
        options.silent = true;
      }
      {
        options.desc = "search words";
        key = "<leader>sw";
        action.__raw = ''function() require("telescope.builtin").live_grep() end'';
        options.silent = true;
      }
      {
        options.desc = "search words (in hidden files)";
        key = "<leader>sW";
        action.__raw = ''
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end
        '';
        options.silent = true;
      }
      {
        options.desc = "search buffers";
        key = "<leader>sb";
        action.__raw = ''function() require("telescope.builtin").buffers() end'';
        options.silent = true;
      }
      {
        options.desc = "search word under cursor";
        key = "<leader>sc";
        action.__raw = ''function() require("telescope.builtin").grep_string() end'';
        options.silent = true;
      }
      {
        options.desc = "search Vim commands";
        key = "<leader>sC";
        action.__raw = ''function() require("telescope.builtin").commands() end'';
        options.silent = true;
      }
      {
        options.desc = "search Vim keymaps";
        key = "<leader>sk";
        action.__raw = ''function() require("telescope.builtin").keymaps() end'';
        options.silent = true;
      }
      {
        options.desc = "search Vim themes";
        key = "<leader>st";
        action.__raw = ''function() require("telescope.builtin").colorscheme { enable_preview = true } end'';
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
        action.__raw = ''function() require("telescope.builtin").git_branches() end'';
        options.silent = true;
      }
      {
        options.desc = "find Git commits";
        key = "<leader>sc";
        action.__raw = ''function() require("telescope.builtin").git_commits() end'';
        options.silent = true;
      }
      {
        options.desc = "Git status";
        key = "<leader>st";
        action.__raw = ''function() require("telescope.builtin").git_status() end'';
        options.silent = true;
      }
      {
        options.desc = "Search diagnostics";
        key = "<leader>sD";
        action.__raw = ''function() require("telescope.builtin").diagnostics() end'';
        options.silent = true;
      }
      {
        options.desc = "Search symbols";
        key = "<leader>ss";
        action.__raw = ''function() require("telescope.builtin").lsp_document_symbols() end'';
        options.silent = true;
      }
    ];
  };
}
