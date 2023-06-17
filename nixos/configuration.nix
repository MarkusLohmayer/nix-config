{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "nixos";
    firewall.enable = false;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  programs.ssh.startAgent = true;

  time.timeZone = "Europe/Berlin";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      markus = {
        isNormalUser = true;
        extraGroups = ["wheel"];
      };
    };
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    git
    vim
  ];

  system = {
    stateVersion = "23.05";
  };
}
