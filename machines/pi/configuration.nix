{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  boot.blacklistedKernelModules = [
    "bluetooth" "btbc" "btstdio" "btusb" "hci_uart" # Bluetooth
    # "brcmfmac" "brcmutil" # WiFi
    "joydev" # Joystick
    "8021q" "bridge" "garp" "stp" "llc" "macvlan" # Networking
  ];

  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "d494711d";

  networking.hostName = "pi";

  networking.wireless = {
    enable = true;
    environmentFile = config.sops.secrets."wifi".path;
    networks."@ssid@".psk = "@pass@";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

  powerManagement.cpuFreqGovernor = "powersafe";

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

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  programs.ssh.startAgent = true;

  services.zfs = {
    autoScrub.enable = true;
    autoScrub.interval = "*-*-1 12:00";
    trim.enable = true;
  };

  fileSystems."/var/log" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=512M" ];
  };
  services.journald.extraConfig = ''
    SystemMaxUse=300M
    Storage=volatile
  '';

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      wifi = {};
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
