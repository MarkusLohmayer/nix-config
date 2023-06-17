{
  # config,
  pkgs,
  # lib,
  ...
}: {
  # https://rycee.gitlab.io/home-manager/options.html

  home = {
    stateVersion = "23.05";
    username = "markus";
    homeDirectory = "/home/markus";
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

  # home.shellAliases."f" = "vifm";

  home.packages = with pkgs; [
    # ls -G (colors) not working (but now using exa)
    coreutils

    # curl
    # wget
    tree

    # ncdu

    # nodejs
    # nodePackages.typescript

    comma

    # vifm
  ];
}
