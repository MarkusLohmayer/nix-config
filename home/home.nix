{ config, pkgs, lib, ... }:

{
  # https://rycee.gitlab.io/home-manager/options.html

  home.stateVersion = "22.05";

  home.username = "markus";
  home.homeDirectory = "/Users/markus";

  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      delay = 15;
      show_program_path = true;
    };
  };


  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };
  home.shellAliases."cat" = "bat";


  home.shellAliases."f" = "vifm";


  home.shellAliases."audio-dl" = "youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0";

  home.sessionPath = [
    "$HOME/ltd-staff12-scripts"
  ];


  home.packages = with pkgs; [

    # ls -G (colors) not working
    # coreutils

    curl
    wget
    tree

    ncdu

    # nodejs
    # nodePackages.typescript

    vifm

    # Useful nix related tools
    # cachix # adding/managing alternative binary caches hosted by Cachix
    # comma # run software from without installing it
    # niv # easy dependency management for nix projects
    # nodePackages.node2nix

    pandoc

    ffmpeg

    youtube-dl

    # TODO: Unknown option UseKeychain
    # https://github.com/NixOS/nixpkgs/issues/62353
    # mosh

  ] ++ lib.optionals stdenv.isDarwin [
    # useful macOS CLI commands
    m-cli
    # select default applications for document types and URL schemes
    # duti
  ];

}
