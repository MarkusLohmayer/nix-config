{...}: {
  config = {
    globals.mapleader = " ";
    keymaps = [
      {
        options.desc = "write";
        key = "<leader>w";
        action = "<cmd>write<cr>";
        options.silent = true;
      }
      {
        options.desc = "quit";
        key = "<leader>q";
        action = "<cmd>quit<cr>";
        options.silent = true;
      }
      {
        options.desc = "force quit";
        key = "<leader>Q";
        action = "<cmd>quit!<cr>";
        options.silent = true;
      }
      {
        # delete (without yank)
        mode = ["n" "v"];
        key = "x";
        action = "\"_x";
        options.silent = true;
      }
      {
        # paste (without yank)
        mode = "v";
        key = "p";
        action = "\"_dP";
        options.silent = true;
      }
      {
        options.desc = "fix last typo";
        mode = "i";
        key = "<C-l>";
        action = "<c-g>u<Esc>[s1z=`]a<c-g>u";
        options.silent = true;
      }
      {
        # indent and stay in visual mode
        mode = "v";
        key = "<";
        action = "<gv";
        options.silent = true;
      }
      {
        # indent and stay in visual mode
        mode = "v";
        key = ">";
        action = ">gv";
        options.silent = true;
      }
      {
        # indent and stay in visual mode
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.silent = true;
      }
      {
        # indent and stay in visual mode
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.silent = true;
      }
    ];
  };
}
