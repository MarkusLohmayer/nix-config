{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  sops = {
    # edit with `nix run nixpkgs#sops ./secrets/secrets.yaml`
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    secrets = {
      root.neededForUsers = true;
      markus.neededForUsers = true;
      wifi = {};
      mqtt_root = {};
      mqtt_fusebox = {};
      mqtt_zigbee = {};
      zigbee2mqtt = {
        owner = "zigbee2mqtt";
        path = "/var/lib/zigbee2mqtt/secret.yaml";
      };
    };
  };

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

  # console.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

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
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      # root.hashedPasswordFile = config.sops.secrets.root.path;
      markus = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        # hashedPasswordFile = config.sops.secrets.markus.path;
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

  services.sanoid = {
    enable = true;
    interval = "daily";
    templates = {
      local = {
        autosnap = true;
        autoprune = true;
        recursive = "zfs";
        daily = 31;
        monthly = 12;
      };
    };
    datasets = {
      "rpool/root".useTemplate = ["local"];
      "rpool/home".useTemplate = ["local"];
      "rpool/var".useTemplate = ["local"];
    };
  };

  fileSystems."/var/log" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=512M"];
  };
  services.journald.extraConfig = ''
    SystemMaxUse=64M
    RuntimeMaxUse=64M
    Storage=volatile
  '';

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        users.root = {
          acl = ["readwrite #"];
          passwordFile = config.sops.secrets."mqtt_root".path;
        };
        users.fusebox = {
          acl = ["readwrite fusebox/#"];
          passwordFile = config.sops.secrets."mqtt_fusebox".path;
        };
        users.zigbee = {
          acl = ["readwrite zigbee/#"];
          passwordFile = config.sops.secrets."mqtt_zigbee".path;
        };
      }
    ];
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      permit_join = false;
      serial.port = "/dev/ttyUSB0";
      mqtt = {
        server = "mqtt://localhost:1883";
        user = "!secret.yaml user";
        password = "!secret.yaml password";
        base_topic = "zigbee";
      };
      advanced = {
        log_level = "warn";
        # log_directory = "/var/log";
        # log_file = "zigbee2mqtt.log";
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
