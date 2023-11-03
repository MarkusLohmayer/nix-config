{...}: {
  config = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;

          hls.enable = true;

          julials.enable = true; # must be installed from Julia

          # ltex.enable = true;

          lua-ls.enable = true;

          nil_ls.enable = true;

          texlab = {
            enable = true;
            extraOptions.settings.texlab = {
              build = {
                executable = "latexmk";
                args = ["-pdflatex" "-interaction=nonstopmode" "-synctex=1" "%f"];
                onSave = true;
                forwardSearchAfter = true;
              };
              # for debugging:
              # forwardSearch = {
              #   executable = "kitty";
              #   args = ["%l"];
              # };
              forwardSearch = {
                executable = "/Applications/Skim.app/Contents/SharedSupport/displayline";
                args = [
                  "-r" # reload
                  "-g" # don't move focus to Skim
                  # "-b" # reading bar
                  "%l" # line number
                  "%p" # PDF file
                  "%f" # TeX file
                ];
              };
              # forwardSearch = {
              #   executable = "zathura";
              #   args = [
              #     "--synctex-forward"
              #     "%l:1:%f"
              #     "%p"
              #   ];
              # };
              # chktex = {
              #   onOpenAndSave = true;
              # };
              diagnostics = {
                ignoredPatterns = [
                  "Overfull"
                  "Underfull"
                ];
              };
            };
          };
        };
      };

      lspsaga = {
        enable = true;
      };

      none-ls = {
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
            # nixpkgs_fmt.enable = true; # Formatter for nixpkgs
            prettier.enable = true;
            prettier.withArgs = ''
              {
                extra_filetypes = { "svelte" },
                extra_args = { "--no-semi", "--single-quote" },
              }
            '';
            shfmt.enable = true; # shell scripts
            stylua.enable = true; # Lua
            taplo.enable = true; # TOML
          };
        };
      };
    };

    keymaps = [
      {
        options.desc = "LSP finder";
        key = "<leader>lf";
        action = ":Lspsaga finder<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP code action";
        key = "<leader>la";
        action = ":Lspsaga code_action<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP rename";
        key = "<leader>lr";
        action = ":Lspsaga rename<CR>";
        options.silent = true;
      }
      {
        options.desc = "LSP peek definition";
        key = "<leader>ld";
        action = ":Lspsaga peek_definition<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP goto definition";
        key = "<leader>lD";
        action = ":Lspsaga goto_definition<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP peek type definition";
        key = "<leader>lt";
        action = ":Lspsaga peek_type_definition<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP goto type definition";
        key = "<leader>lT";
        action = ":Lspsaga goto_type_definition<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP format code";
        key = "<leader>lf";
        action = ":lua vim.lsp.buf.format()<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP next diagnostic";
        key = "<leader>ln";
        action = ":Lspsaga diagnostic_jump_next<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP previous diagnostic";
        key = "<leader>lN";
        action = ":Lspsaga diagnostic_jump_prev<cr>";
        options.silent = true;
      }
      {
        options.desc = "LSP hover documentation";
        key = "<leader>lh";
        action = ":Lspsaga hover_doc<cr>";
        options.silent = true;
      }
    ];

    autoCmd = [
      {
        event = "FileType";
        pattern = "tex";
        command = ''lua vim.keymap.set('n', '<c-f>', '<cmd>TexlabForward<cr>', { silent = true, desc = 'Forward search' })'';
      }
      # {
      #   event = ["BufWritePre"];
      #   command = "lua vim.lsp.buf.format()";
      # }
    ];
  };
}
