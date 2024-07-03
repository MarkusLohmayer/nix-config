# https://github.com/nix-community/nixvim
# https://nix-community.github.io/nixvim/
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
        extraSpecialArgs = {
          homeDirectory = config.home.homeDirectory;
        };
        module = {
          imports = [./nixvim];
        };
      }
    )
  ];

  home.sessionVariables."EDITOR" = "nvim";
  home.shellAliases."v" = "nvim";
}
