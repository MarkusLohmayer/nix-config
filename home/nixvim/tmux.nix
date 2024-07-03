{pkgs, ...}: let
  slimux = pkgs.fetchFromGitHub {
    owner = "EvWilson";
    repo = "slimux.nvim";
    rev = "0fee8804d95fa2710ee50fb2cd187589f8561d76";
    sha256 = "FXfx07M+Tcclh33AGLrVi9mTBOwEGKdGcurAkCiEXmg=";
  };
in {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      Navigator-nvim
      slimux
    ];
    extraConfigLua = ''
      require("Navigator").setup()

      local slimux = require "slimux"
      slimux.setup {
        target_socket = slimux.get_tmux_socket(),
        target_pane = string.format("{last}", slimux.get_tmux_window()),
      }
    '';
    keymaps = [
      {
        options.desc = "move left";
        key = "<A-h>";
        action = "<cmd>NavigatorLeft<cr>";
        options.silent = true;
      }
      {
        options.desc = "move down";
        key = "<A-j>";
        action = "<cmd>NavigatorDown<cr>";
        options.silent = true;
      }
      {
        options.desc = "move up";
        key = "<A-k>";
        action = "<cmd>NavigatorUp<cr>";
        options.silent = true;
      }
      {
        options.desc = "move right";
        key = "<A-l>";
        action = "<cmd>NavigatorRight<cr>";
        options.silent = true;
      }
      {
        options.desc = "send to tmux pane";
        key = "<leader>r";
        action = '':lua require("slimux").send_paragraph_text()<cr>'';
        options.silent = true;
      }
      {
        options.desc = "send to tmux pane";
        mode = "v";
        key = "<leader>r";
        action = '':lua require("slimux").send_highlighted_text()<cr>'';
        options.silent = true;
      }
    ];
  };
}
