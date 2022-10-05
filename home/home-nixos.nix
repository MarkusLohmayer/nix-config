{ config, pkgs, lib, ... }:
{
  # https://rycee.gitlab.io/home-manager/options.html
  home = {
    stateVersion = "22.05";
    username = "markus";
    homeDirectory = "/home/markus";
    shellAliases = {
      "f" = "vifm";
    };
    # TODO how to use hostname in variable? (want "$HOME/${host}-scripts")
    sessionPath = [
      "$HOME/scripts"
    ];
    packages = with pkgs; [
      # ls -G (colors) not working (but now using exa)
      coreutils

      curl
      wget
      tree

      ncdu

      # nodejs
      # nodePackages.typescript

      vifm
    ];
  };
  programs = {
    htop = {
      enable = true;
      settings = {
        tree_view = true;
        delay = 15;
        show_program_path = true;
      };
    };
  };
}
