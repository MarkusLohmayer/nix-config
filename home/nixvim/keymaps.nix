{helpers, ...}: {
  config = {
    globals.mapleader = " ";
    maps = helpers.mkMaps {silent = true;} {

      # "<leader>f" = {
      #   desc = " Files";
      # };
      # "<leader>g" = {
      #   desc = " Git";
      # };
      # "<leader>l" = {
      #   desc = " LSP";
      # };

      normal."<leader>w" = {
        action = "<cmd>write<cr>";
        desc = "write";
      };
      normal."<leader>q" = {
        action = "<cmd>quit<cr>";
        desc = "quit";
      };
      normal."<leader>Q" = {
        action = "<cmd>quit!<cr>";
        desc = "force quit";
      };

      normal."x" = {
        action = "\"_x";
      };
      visual."x" = {
        action = "\"_x";
      };
      visual."p" = {
        action = "\"_dP";
      };

      insert."<C-l>" = {
        action = "<c-g>u<Esc>[s1z=`]a<c-g>u";
        desc = "fix last typo";
      };

      # indent and stay in visual mode
      visual."<" = "<gv";
      visual.">" = ">gv";

      # move selection
      visual."K" = ":m '<-2<CR>gv=gv";
      visual."J" = ":m '>+1<CR>gv=gv";

    };
  };
}
