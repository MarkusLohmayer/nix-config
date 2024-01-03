{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # ./sops.nix
    # ./wifi.nix
    # ./iot.nix
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

  networking.firewall.enable = true;

  console.enable = false;

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
      markus = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        hashedPassword = "$y$j9T$xBfPZyYkqlykHbmRnjucR0$piOsPeXLpMY0360SpfRygb3xUR4d5VaLqohx8uXYg9C";
      };
    };
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    git
    vim
  ];

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

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
      "rpool/home".useTemplate = ["local"];
      "rpool/persist".useTemplate = ["local"];
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=64M
    RuntimeMaxUse=64M
    Storage=volatile
  '';

  system = {
    stateVersion = "23.11";
  };
}
