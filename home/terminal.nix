{
  pkgs,
  lib,
  ...
}: {
  # https://nix-community.github.io/home-manager/options.html

  # moden replacement for `cat`
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
    };
  };
  home.shellAliases."cat" = "bat";

  # activate per-project developer environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # modern replacement for `ls`
  programs.eza = {
    enable = true;
  };

  # CPU / memory usage monitor
  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      delay = 15;
      show_program_path = true;
    };
  };

  # files database for nixpkgs
  programs.nix-index.enable = true;

  # modern replacement for cd
  programs.zoxide = {
    enable = true;
  };

  home.shellAliases = {
    "..." = "../..";
    "...." = "../../..";

    l = "ls -lah";

    idm = "totp get idm | pbcopy";
  };

  home.sessionPath = [
    "$HOME/scripts"
  ];

  home.packages = with pkgs;
    [
      # basic GNU commands
      coreutils

      # modern replacement for `find` (files by name)
      fd

      # modern `sed` alternative (find and replace)
      sd

      # modern replacement for `grep` (find text in lines (in files))
      ripgrep

      # HTTP download (and more)
      curl
      wget

      # print file tree
      tree

      # TUI app for disk usage
      ncdu

      # run software without installing
      comma

      # extends SSH to support roaming and intermittent connectivity
      # TODO: Unknown option UseKeychain
      # https://github.com/NixOS/nixpkgs/issues/62353
      # mosh
    ]
    ++ lib.optionals stdenv.isDarwin [
      # useful macOS CLI commands
      m-cli
      # select default applications for document types and URL schemes
      duti
    ];
}
