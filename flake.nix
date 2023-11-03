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

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nix-index-database,
    nixvim,
    ...
  }: {
    darwinConfigurations = {
      m-one = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./m-one/configuration.nix
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
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          overlays = [
            self.overlay
          ];
        };
        extraSpecialArgs = {
          inherit nixvim;
        };
        modules = [
          nix-index-database.hmModules.nix-index
          ./m-one/home.nix

          ./home/git.nix
          ./home/julia.nix
          ./home/latex.nix
          ./home/nixvim.nix
          ./home/nushell.nix
          ./home/ssh.nix
          ./home/starhip.nix
          ./home/terminal.nix
          ./home/tmux.nix
          ./home/vscode.nix
          ./home/zsh.nix

          ./home/kitty.nix
          ./home/zathura.nix
        ];
      };

      "markus@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [
            self.overlay
          ];
        };
        extraSpecialArgs = {
          inherit nixvim;
        };
        modules = [
          nix-index-database.hmModules.nix-index
          ./nixos/home.nix

          ./home/git.nix
          ./home/julia.nix
          ./home/nixvim.nix
          ./home/ssh.nix
          ./home/starhip.nix
          ./home/terminal.nix
          ./home/tmux.nix
          ./home/zsh.nix
        ];
      };
    };

    overlay = final: prev: let
      tilish = prev.callPackage ./overlay/tilish.nix {};
    in {
      tmuxPlugins = prev.tmuxPlugins // {inherit tilish;};
    };
  };
}
