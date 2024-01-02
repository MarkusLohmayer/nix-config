{pkgs, ...}: {
  # https://nix-community.github.io/home-manager/options.html

  home = {
    stateVersion = "22.05";
    username = "markus";
    homeDirectory = "/Users/markus";
  };

  home.packages = with pkgs; [
    # convert files from one markup format into another
    pandoc

    rsync
  ];
}
