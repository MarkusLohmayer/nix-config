{...}: {
  config = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          julials.enable = true; # must be installed from Julia
          ltex.enable = true;
          lua-ls.enable = true;
          nil_ls.enable = true;
          texlab = {
            enable = true;
            extraOptions.settings = {
              build = {
                executable = "latexmk";
                # args = { "-pdflatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true;
                forwardSearchAfter = true;
              };
              # forwardSearch = {
              #   -- executable = "zathura",
              #   -- args = {
              #   --   "--synctex-forward",
              #   --   "%l:1:%f",
              #   --   "%p",
              #   -- },
              #   executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
              #   args = {
              #     "-r", -- reload file
              #     "-g", -- leave Skim in the background
              #     "-b", -- show yellow reading bar
              #     "%l", -- line number
              #     "%p", -- pdf file
              #     "%f", -- tex file
              #   },
              # },
              # chktex = {
              #   onOpenAndSave = true,
              # },
              # -- diagnostics = {
              # --   -- ignoredPatterns = {
              # --   --   "Overfull",
              # --   --   "Underfull",
              # --   --   "has already been used",
              # --   -- },
              # -- },
            };
          };
        };
      };

      lspsaga = {
        enable = true;
        icons.codeAction = "";
        signs = {
          error = "";
          hint = "";
          info = "";
          warning = "";
        };
      };

      null-ls = {
        enable = true;
        # cmd = ["bash -c nvim"];
        # debug = true;
        sources = {
          code_actions = {
            # statix.enable = true;
          };
          diagnostics = {
            # statix.enable = true;
            # deadnix.enable = true;
          };
          formatting = {
            alejandra.enable = true; # Nix
            black.enable = true; # Python
            black.withArgs = ''
              {
                extra_args = { "--fast" },
              }
            '';
            cbfmt.enable = true; # code blocks in Markdown
            prettier.enable = true;
            prettier.withArgs = ''
              {
                extra_filetypes = { "toml" },
                extra_args = { "--no-semi", "--single-quote" },
              }
            '';
            shfmt.enable = true; # shell scripts
            stylua.enable = true; # Lua
            # nixpkgs_fmt.enable = true;
          };
        };
      };

    };

    maps = {
      normal = {
        # Async LSP Finder
        "<leader>gh" = {
          action = ":Lspsaga lsp_finder<CR>";
          silent = true;
          desc = "LSP finder";
        };
        # Code Action
        "<leader>la" = {
          action = ":Lspsaga code_action<CR>";
          silent = true;
          desc = "Code action";
        };
        "<leader>lr" = {
          action = ":Lspsaga rename<CR>";
          silent = true;
          desc = "Rename";
        };
        "<leader>gd" = {
          action = ":Lspsaga preview_definition<CR>";
          silent = true;
          desc = "view definitions";
        };
        "<leader>lf" = {
          action = ":lua vim.lsp.buf.format()<CR>";
          silent = true;
          desc = "Format code";
        };
      };
      visual = {
        "<leader>la" = {
          silent = true;
          action = ":<C-U>Lspsaga range_code_action<CR>";
          desc = "Code action";
        };
      };
    };
  };
}
