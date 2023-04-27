{ config, pkgs, libs, ...}:
{

  home.packages = with pkgs; [
    neovim

    # modern replacement for `find`
    fd
    # modern replacement for `grep`
    ripgrep

    stylua

    black

    nodejs
    nodePackages.neovim
    nodePackages.prettier

    # cargo is required to install Nix language server via mason.nvim
    cargo
  ];

  # xdg.configFile."nvim".source = ./nvim;
  # work with mutable version for now
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/nvim";

  home.sessionVariables."EDITOR" = "nvim";
  home.shellAliases."v" = "nvim";

  # SyncTeX requires dbus
  # home.sessionVariables."DBUS_SESSION_BUS_ADDRESS" = "unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET";

}
