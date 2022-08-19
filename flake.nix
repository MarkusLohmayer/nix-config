{
  description = "Nix system configuration of Markus Lohmayer";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    let

      inherit (nixpkgs.lib)
        attrValues
        optionalAttrs
        singleton
        ;

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays = attrValues self.overlays ++ singleton (
          # use x86 version of packages that don't build on Apple Silicon yet
          final: prev: (
            optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
              inherit (final.pkgs-x86)
                # ...
                ;
            }
          )
        );
      };

    in
    {

      darwinConfigurations = rec {
        ltd-staff12 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = attrValues self.darwinModules ++ [
            ./configuration.nix
          ];
        };
      };


      homeConfigurations.markus = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          ./home/home.nix

          ./home/git.nix
          ./home/kitty.nix
          ./home/latex.nix
          ./home/neovim.nix
          ./home/tmux.nix
          ./home/zsh.nix
        ];
      };


      overlays = {
      };

      darwinModules = {
      };

   };

}
