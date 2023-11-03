{pkgs, ...}:
let
  slimux = pkgs.fetchFromGitHub {
    owner = "EvWilson";
    repo = "slimux.nvim";
    rev = "bd12bc865d5a70d6025a801df95996e954f9ac31";
    sha256 = "FX+WQFUzccfi2fTCx0ntgTfdBTlJFqMGJaQsfQt7Z4Q=";
  };
in
{
  config = {
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
