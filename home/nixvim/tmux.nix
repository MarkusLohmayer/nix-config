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
    maps = {
      normal = {
        "<A-h>" = {
          action = "<cmd>NavigatorLeft<cr>";
          silent = true;
          desc = "Move left";
        };
        "<A-j>" = {
          action = "<cmd>NavigatorDown<cr>";
          silent = true;
          desc = "Move down";
        };
        "<A-k>" = {
          action = "<cmd>NavigatorUp<cr>";
          silent = true;
          desc = "Move up";
        };
        "<A-l>" = {
          action = "<cmd>NavigatorRight<cr>";
          silent = true;
          desc = "Move right";
        };

        "<leader>r" = {
          action = '':lua require("slimux").send_highlighted_text()<CR>'';
          silent = true;
          desc = "Send to tmux pane";
        };
      };
      visual = {
        "<leader>r" = {
          action = '':lua require("slimux").send_paragraph_text()<CR>'';
          silent = true;
          desc = "Send to tmux pane";
        };
      };
    };
  };
}
