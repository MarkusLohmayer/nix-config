{...}: {
  programs.nixvim = {
    plugins.barbar = {
      enable = true;
      settings = {
        animation = true;
        clickable = true;
        maximum_length = 30;
        maximum_padding = 1;
        minimum_padding = 1;
        semantic_letters = true;
        sidebar_filetypes = {
          "neo-tree" = {
            event = "BufWipeout";
          };
        };
      };
    };
    keymaps = [
      {
        options.desc = "previous buffer";
        key = "<S-h>";
        action = "<cmd>BufferPrevious<cr>";
        options.silent = true;
      }
      {
        options.desc = "next buffer";
        key = "<S-l>";
        action = "<cmd>BufferNext<cr>";
        options.silent = true;
      }
      {
        options.desc = "close buffer";
        key = "<S-q>";
        action = "<cmd>BufferClose<cr>";
        options.silent = true;
      }
      {
        options.desc = "pin buffer";
        key = "<leader>bp";
        action = "<cmd>BufferPin<cr>";
        options.silent = true;
      }
      {
        options.desc = "restore buffer";
        key = "<leader>br";
        action = "<cmd>BufferRestore<cr>";
        options.silent = true;
      }
      {
        options.desc = "close all buffers except current";
        key = "<leader>bc";
        action = "<cmd>BufferCloseAllButCurrent<cr>";
        options.silent = true;
      }
      {
        options.desc = "close all buffers";
        key = "<leader>bC";
        action = "<cmd>BufferWipeout<cr>";
        options.silent = true;
      }
      {
        options.desc = "pick buffer to close";
        key = "<leader>bd";
        action = "<cmd>BufferPickDelete<cr>";
        options.silent = true;
      }
    ];
  };
}
