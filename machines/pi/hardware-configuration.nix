# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    initrd.availableKernelModules = ["xhci_pci" "usb_storage" "usbhid" "uas"];
    blacklistedKernelModules = [
      # Bluetooth
      "btstdio"
      "bluetooth"
      "btbc"
      "btusb"
      "hci_uart"
      # WiFi
      # "brcmfmac"
      # "brcmutil"
      # Joystick
      "joydev"
      # Networking
      "bridge"
      "garp"
      "stp"
      "llc"
      "macvlan"
      "8021q"
    ];
    # supportedFilesystems = ["zfs"];
    loader.systemd-boot.enable = true;
    # loader.generic-extlinux-compatible.enable = false;
    # loader.efi.canTouchEfiVariables = true;
  };

  fileSystems."/persist".neededForBoot = true;
}
