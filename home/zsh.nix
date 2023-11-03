{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    # enableAutosuggestions = true;
    autocd = true; # enter directory if typed directly into shell
    history.extended = true; # save timestamp in history
    initExtra = ''
      # make cd behave like pushd (add to directory stack)
      # use cd -<TAB> to naviagate to previous directory
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

      # use ctrl-z to suspend/resume process
      function _fg() {
          zle push-input
          BUFFER="fg"
          zle accept-line
      }
      zle -N _fg
      bindkey -M viins '^z' _fg
      bindkey -M vicmd '^z' _fg

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

  programs.direnv.enableZshIntegration = true;
  programs.nix-index.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration = true;
}
