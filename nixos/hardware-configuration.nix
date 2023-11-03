{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];
  boot.loader.systemd-boot.enable = true;
  fileSystems."/".device = "/dev/disk/by-label/nixos";
}
