{pkgs, ...}: {
  # https://nix-community.github.io/home-manager/options.html

  home = {
    stateVersion = "23.11";
    username = "markus";
    homeDirectory = "/home/markus";
  };

  home.packages = with pkgs; [];
}
