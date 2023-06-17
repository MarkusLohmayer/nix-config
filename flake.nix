{
  description = "Nix system and home configuration of Markus Lohmayer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:pta2002/nixvim";
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    nix-index-database,
    nixvim,
    ...
  }: {
    darwinConfigurations = {
      ltd-staff12 = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./configuration.nix
        ];
      };

      m-one = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
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
        extraSpecialArgs = {
          inherit nixvim;
        };
        modules = [
          nix-index-database.hmModules.nix-index
          ./home/home.nix

          ./home/git.nix
          ./home/julia.nix
          ./home/latex.nix
          ./home/nixvim.nix
          ./home/ssh.nix
          ./home/tmux.nix
          ./home/zsh.nix

          ./home/kitty.nix
          ./home/zathura.nix
        ];
      };

      "markus@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = {
          inherit nixvim;
        };
        modules = [
          nix-index-database.hmModules.nix-index
          ./home/home-nixos.nix

          ./home/git.nix
          ./home/julia.nix
          # ./home/latex.nix
          ./home/nixvim.nix
          ./home/ssh.nix
          ./home/tmux.nix
          ./home/zsh.nix
        ];
      };
    };
  };
}
