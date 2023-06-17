{
  config,
  pkgs,
  nixvim,
  ...
}: {
  home.packages = with pkgs; [
    (
      nixvim.legacyPackages."${system}".makeNixvimWithModule {
        inherit pkgs;
        module = {
          imports = [./nixvim];
        };
      }
    )

    # modern replacement for `find`
    fd
    # modern replacement for `grep`
    ripgrep
  ];

  home.sessionVariables."EDITOR" = "nvim";
  home.shellAliases."v" = "nvim";

  xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/nixvim/spell/en.utf-8.add";
}
