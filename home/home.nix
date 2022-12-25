{ config, pkgs, lib, ... }:

{
  # https://rycee.gitlab.io/home-manager/options.html

  home = {
    stateVersion = "22.05";
    username = "markus";
    homeDirectory = "/Users/markus";
  };

  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      delay = 15;
      show_program_path = true;
    };
  };

  programs.nix-index.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.shellAliases."f" = "vifm";


  home.shellAliases."audio-dl" = "youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0";

  # TODO how to use hostname in variable? (want "$HOME/${host}-scripts")
  home.sessionPath = [
    "$HOME/scripts"
  ];


  home.packages = with pkgs; [

    # ls -G (colors) not working (but now using exa)
    coreutils

    curl
    wget
    tree

    ncdu

    # nodejs
    # nodePackages.typescript

    comma

    vifm

    helix

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
    duti
  ];

}
