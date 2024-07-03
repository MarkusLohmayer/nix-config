{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
    ];
    plugins = {
      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "buffer";}
            {name = "emoji";}
            {name = "latex_symbols";}
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "nvim_lsp_document_symbol";}
            {name = "nvim_lsp_signature_help";}
            {name = "luasnip";}
          ];
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          window = {
            documentation.maxHeight = "math.floor(40 * (40 / vim.o.lines))";
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
              colOffset = -3;
              sidePadding = 0;
            };
          };
          formatting = {
            fields = ["kind" "abbr" "menu"];
          };
          mapping = {
            # use ctrl-k and ctrl-j to select completions
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            # ctrl-e aborts completion
            "<C-e>" = "cmp.mapping.abort()";
            # tab inserts (pre)selected completion
            "<Tab>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
            # return replaces current text with the actively selected completion
            "<CR>" = ''
              cmp.mapping({
                i = function(fallback)
                  if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                  else
                    fallback()
                  end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
              })
            '';
            # use ctrl-b and ctrl-f to scroll completions menu
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
          };
        };
        # cmdline = {
        #   "/" = {
        #     mapping = {
        #       __raw = "cmp.mapping.preset.cmdline()";
        #     };
        #     sources = [
        #       {
        #         name = "buffer";
        #       }
        #     ];
        #   };
        #   ":" = {
        #     mapping = {
        #       __raw = "cmp.mapping.preset.cmdline()";
        #     };
        #     sources = [
        #       {
        #         name = "path";
        #       }
        #       {
        #         name = "cmdline";
        #         option = {
        #           ignore_cmds = [
        #             "Man"
        #             "!"
        #           ];
        #         };
        #       }
        #     ];
        #   };
        # };
      };

      # add vscode-like pictograms to neovim built-in lsp
      lspkind = {
        enable = true;
        # mode = "symbol";
        mode = "symbol_text";
        cmp.enable = true;
      };
    };
  };
}
