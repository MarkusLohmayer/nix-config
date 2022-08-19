{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    # enableSyntaxHighlighting = true;
    # enableAutosuggestions = true;
    autocd = true;
    # save timestamp in history 
    history.extended = true;
    # initExtraBeforeCompInit = ''
    initExtra = ''
      # ZSH_DISABLE_COMPFIX="true"

      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

      function wake {
        curl -XPOST http://ltd-monitor.ltd.uni-erlangen.de/api/wake/$1
      }

      function doi2bib {
        curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex"
      }

      function dec2hex {
        printf "%X\n" $1
      }

      function hex2dec {
        printf "%d\n" 0x$1
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "git"
        "tmux"
      ];
    };
  };


  programs.starship = {
    enable = true;
    # https://starship.rs/config/
   settings = {
      add_newline = false;

      cmd_duration = {
        min_time = 500; # ms
        format = "[$duration]($style) ";
      };
      package.disabled = true;
    };
  };

}
