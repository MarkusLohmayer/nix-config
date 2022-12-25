{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    # enableAutosuggestions = true;
    autocd = true;
    # save timestamp in history
    history.extended = true;
    initExtra = ''
      # ZSH_DISABLE_COMPFIX="true"

      setopt AUTO_PUSHD

      unsetopt MENU_COMPLETE
      setopt AUTO_MENU
      setopt COMPLETE_IN_WORD
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

      setopt ALWAYS_TO_END

      unsetopt FLOW_CONTROL

      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

      function take {
        mkdir -p $@ && cd $@
      }

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
  };

  home.shellAliases = {
    "..." = "../..";
    "...." = "../../..";

    ds = "dirs -v | head -n 10";
    "1" = "cd -1";
    "2" = "cd -2";
    "3" = "cd -3";
    "4" = "cd -4";
    "5" = "cd -5";
    "6" = "cd -6";
    "7" = "cd -7";
    "8" = "cd -8";
    "9" = "cd -9";

    l = "ls -lah";
  };


  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # https://starship.rs/config/
    settings = {
      add_newline = true;

      git_branch = { symbol = "🌱 "; };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_state = {
        format = "[($state($progress_current of $progress_total))]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = "🏳";
        ahead = "💨";
        behind = "😰";
        diverged = "😵";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++($count)](green)";
        renamed = "👅";
        deleted = "🗑️";
      };

      cmd_duration = {
        min_time = 500; # ms
        format = "[$duration]($style) ";
      };

      # if working directory is a package repository, show the version number
      # package.disabled = true;
    };
  };


  # modern replacement for `ls`
  programs.exa = {
    enable = true;
    enableAliases = true;
  };


  # moden replacement for `cat`
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };
  home.shellAliases."cat" = "bat";

}
