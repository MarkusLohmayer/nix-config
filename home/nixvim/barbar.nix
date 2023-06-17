{...}: {
  config = {
    plugins.barbar = {
      enable = true;
      animation = true;
      clickable = true;
      semanticLetters = true;
      excludeFileNames = ["alpha"];
      icons = {
        button = "";
        diagnostics = {
          error = {
            enable = true;
            icon = "ﬀ";
          };
          hint.enable = true;
        };
        filetype = {
          enable = true;
          customColors = true;
        };
        modified.button = "●";
        pinned.button = "";
        inactive.button = "×";
      };
      maximumPadding = 1;
      minimumPadding = 1;
      maximumLength = 30;
      sidebarFiletypes = {
        "neo-tree" = {
          event = "BufWipeout";
        };
      };
    };

    maps.normal = {

      "<S-h>" = {
        action = "<cmd>BufferPrevious<cr>";
        silent = true;
        desc = "previous buffer";
      };
      "<S-l>" = {
        action = "<cmd>BufferNext<cr>";
        silent = true;
        desc = "next buffer";
      };
      "<S-q>" = {
        action = "<cmd>BufferClose<cr>";
        silent = true;
        desc = "close buffer";
      };


      "<leader>b" = {
        desc = "buffer";
      };
      "<leader>bp" = {
        action = "<cmd>BufferPin<cr>";
        silent = true;
        desc = "pin buffer";
      };
      "<leader>br" = {
        action = "<cmd>BufferRestore<cr>";
        silent = true;
        desc = "restore buffer";
      };
      "<leader>bc" = {
        action = "<cmd>BufferCloseAllButCurrent<cr>";
        silent = true;
        desc = "close all buffers except current";
      };
      "<leader>bC" = {
        action = "<cmd>BufferWipeout<cr>";
        silent = true;
        desc = "close all buffers";
      };
      "<leader>bd" = {
        action = "<cmd>BufferPickDelete<cr>";
        silent = true;
        desc = "pick buffer to close";
      };
    };
  };
}
