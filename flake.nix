{
  description = "Nix system and home configurations of Markus Lohmayer";

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
      url = "github:nix-community/nixvim";
      # url = "git+file:///Users/markus/git/MarkusLohmayer/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
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
    sops-nix,
    impermanence,
    ...
  } @ inputs: {
    darwinConfigurations = {
      m-one = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./machines/m-one/configuration.nix
        ];
      };
    };

    nixosConfigurations = {
      pi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/pi/configuration.nix
          sops-nix.nixosModules.sops
          impermanence.nixosModules.impermanence
          inputs.disko.nixosModules.disko
        ];
        specialArgs = {inherit inputs;};
      };
      nixos-vm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./machines/nixos-vm/configuration.nix
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
          ./machines/m-one/markus.nix

          ./home/git.nix
          ./home/julia.nix
          ./home/latex.nix
          ./home/media.nix
          ./home/nixvim.nix
          ./home/nushell.nix
          ./home/ssh.nix
          ./home/starhip.nix
          ./home/terminal.nix
          ./home/tmate.nix
          ./home/tmux.nix
          ./home/zsh.nix

          ./home/kitty.nix
          ./home/vscode.nix
          # ./home/zathura.nix
        ];
      };

      "markus@pi" = home-manager.lib.homeManagerConfiguration {
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
          ./machines/pi/markus.nix

          ./home/git.nix
          ./home/nixvim.nix
          ./home/ssh.nix
          ./home/starhip.nix
          ./home/terminal.nix
          ./home/tmux.nix
          ./home/zsh.nix
        ];
      };

      "markus@nixos-vm" = home-manager.lib.homeManagerConfiguration {
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
          ./machines/nixos-vm/markus.nix

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
      # tilish = prev.callPackage ./overlay/tilish.nix {};
    in {
      # tmuxPlugins = prev.tmuxPlugins // {inherit tilish;};
    };
  };
}
