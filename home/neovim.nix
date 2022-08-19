{ config, pkgs, libs, ...}:
{

  home.packages = with pkgs; [
    neovim
    
    # `fd` is a simple, fast and user-friendly alternative to `find`
    fd
    # combines the usability of The Silver Searcher with the raw speed of grep
    ripgrep

    stylua
    
    nodePackages.neovim
    nodePackages.prettier
  ];

  # xdg.configFile."nvim".source = ./nvim;
  # work with mutable version for now
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/nvim";

  home.sessionVariables."EDITOR" = "nvim";
  home.shellAliases."v" = "nvim";
 
  programs.zathura = {
    enable = true;
    options = {
      # recolor = true;
      # recolor-darkcolor = "#FDF0ED";
      # recolor-lightcolor = "rgba(0,0,0,0)";
      # default-bg = "rgba(0,0,0,0.7)";
      # default-fg = "#FDF0ED";
    };
  };

}
