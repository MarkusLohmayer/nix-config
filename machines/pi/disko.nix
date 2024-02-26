{
  disko.devices = {
    disk = {
      a = {
        type = "disk";
        device = "/dev/disk/by-id/usb-Micron_CT2000X9PROSSD9_2325E8C44F0A-0:0";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            plainSwap = {
              size = "4G";
              content = {
                type = "swap";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
      b = {
        type = "disk";
        device = "/dev/disk/by-id/usb-Micron_CT2000X9PROSSD9_2338E8C498CC-0:0";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
              };
            };
            plainSwap = {
              size = "4G";
              content = {
                type = "swap";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=25%"
          "mode=755"
        ];
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        mode = "mirror";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          dnodesize = "auto";
          mountpoint = "none";
          xattr = "sa";
        };
        datasets = {
          reserved = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.refreservation = "10G";
          };
          persist = {
            type = "zfs_fs";
            mountpoint = "/persist";
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
        };
      };
    };
  };
}
