{
  inputs,
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
    # Bluetooth
    "bluetooth"
    "btbc"
    "btstdio"
    "btusb"
    "hci_uart"
    # WiFi
    # "brcmfmac"
    # "brcmutil"
    # Joystick
    "joydev"
    # Networking
    "8021q"
    "bridge"
    "garp"
    "stp"
    "llc"
    "macvlan"
  ];

  boot.supportedFilesystems = ["zfs"];
  networking.hostId = "d494711d";

  networking.hostName = "pi";

  networking.wireless = {
    enable = true;
    environmentFile = config.sops.secrets."wifi".path;
    networks."@ssid@".psk = "@pass@";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1883 # MQTT
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

  powerManagement.cpuFreqGovernor = "powersafe";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };

    # make nix shell use the same version of nixpkgs as this flake
    registry = {nixpkgs.flake = inputs.nixpkgs;};
  };

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
    options = ["defaults" "size=512M"];
  };
  services.journald.extraConfig = ''
    SystemMaxUse=300M
    Storage=volatile
  '';

  sops = {
    # edit with `nix run nixpkgs#sops ./secrets/secrets.yaml`
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    secrets = {
      wifi = {};
      mqtt_root = {};
      mqtt_meter = {};
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        users.root = {
          acl = ["readwrite #"];
          passwordFile = config.sops.secrets."mqtt_root".path;
        };
        users.meter = {
          acl = ["write meter/#"];
          passwordFile = config.sops.secrets."mqtt_meter".path;
        };
      }
    ];
  };

  system = {
    stateVersion = "23.11";
  };
}
