{config, ...}: {
  sops.secrets.wifi = {};

  networking.wireless = {
    enable = true;
    environmentFile = config.sops.secrets."wifi".path;
    networks."@ssid@".psk = "@pass@";
  };
}
