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

  console.enable = false;

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
        log_directory = "/var/log";
        log_file = "zigbee2mqtt.log";
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
