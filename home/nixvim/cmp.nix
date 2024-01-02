{
  pkgs,
  helpers,
  ...
}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
    ];

    plugins = {
      cmp-buffer.enable = true;
      cmp-emoji.enable = true;
      cmp-latex-symbols.enable = true;
      cmp-path.enable = true;

      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;

      luasnip.enable = true;
      cmp_luasnip.enable = true;

      nvim-cmp = {
        enable = true;
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
        snippet.expand = "luasnip";

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

      # add vscode-like pictograms to neovim built-in lsp
      lspkind = {
        enable = true;
        # mode = "symbol";
        mode = "symbol_text";
        cmp.enable = true;
      };
    };

    colorschemes.catppuccin.customHighlights = {
      PmenuSel = {
        bg = helpers.mkRaw "colors.base";
        fg = "NONE";
      };
      Pmenu = {
        fg = "#FFFFFF";
        bg = helpers.mkRaw "colors.mantle";
      };
      CmpItemKindSnippet = {
        bg = helpers.mkRaw "colors.mauve";
        fg = "#FFFFFF";
      };
      CmpItemKindKeyword = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindText = {
        bg = helpers.mkRaw "colors.teal";
        fg = "#FFFFFF";
      };
      CmpItemKindMethod = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindConstructor = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindFunction = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindFolder = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindModule = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindConstant = {
        bg = helpers.mkRaw "colors.peach";
        fg = "#FFFFFF";
      };
      CmpItemKindField = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindProperty = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindEnum = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindUnit = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindClass = {
        bg = helpers.mkRaw "colors.yellow";
        fg = "#FFFFFF";
      };
      CmpItemKindVariable = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindFile = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindInterface = {
        bg = helpers.mkRaw "colors.yellow";
        fg = "#FFFFFF";
      };
      CmpItemKindColor = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindReference = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindEnumMember = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindStruct = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindValue = {
        bg = helpers.mkRaw "colors.peach";
        fg = "#FFFFFF";
      };
      CmpItemKindEvent = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindOperator = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindTypeParameter = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindCopilot = {
        bg = helpers.mkRaw "colors.teal";
        fg = "#FFFFFF";
      };
    };
  };
}
