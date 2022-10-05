{
  description = "Nix system and home configuration of Markus Lohmayer";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # flake-utils = {
    #   url = "github:numtide/flake-utils";
    # };

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
        m-one = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = attrValues self.darwinModules ++ [
            ./configuration.nix
          ];
        };
      };


      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };


      homeConfigurations = {
        "markus@m-one" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./home/home.nix

            ./home/git.nix
            ./home/julia.nix
            ./home/kitty.nix
            ./home/latex.nix
            ./home/neovim.nix
            ./home/ssh.nix
            ./home/tmux.nix
            ./home/zsh.nix
          ];
        };
        "markus@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./home/home-nixos.nix

            ./home/git.nix
            ./home/neovim.nix
            ./home/ssh.nix
            ./home/tmux.nix
            ./home/zsh.nix
          ];
        };
      };


      overlays = {
      };

      darwinModules = {
      };

   };

}
