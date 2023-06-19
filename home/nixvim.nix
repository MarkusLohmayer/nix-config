# https://github.com/pta2002/nixvim
# https://pta2002.github.io/nixvim/
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
  xdg.configFile."nvim/spell/de.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/nixvim/spell/de.utf-8.add";
}
