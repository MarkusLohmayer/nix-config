# pi

NixOS on a virtual machine based on UTM

Download NixOS 23.11 SD-card image for `aarch64` CPUs:
https://hydra.nixos.org/job/nixos/release-23.11/nixos.sd_image.aarch64-linux

Decompress image and flash to USB pen drive:

```bash
nix-shell -p zstd --run "unzstd nixos-sd-image-23.11.2082.d02ffbbe834b-aarch64-linux.img.zst"
```

Installation:

```bash
sudo -i

DISK1=/dev/disk/by-id/ata-VENDOR-ID-OF-THE-FIRST-DRIVE
DISK2=/dev/disk/by-id/ata-VENDOR-ID-OF-THE-SECOND-DRIVE

wipefs -a /dev/sdb

parted -a optimal $DISK1 -- mklabel gpt
parted -a optimal $DISK2 -- mklabel gpt

parted $DISK1 -- mkpart ESP fat32 1MiB 513MiB
parted $DISK2 -- mkpart ESP fat32 1MiB 513MiB

parted $DISK1 -- set 1 esp on
parted $DISK2 -- set 1 esp on

parted $DISK1 -- mkpart primary linux-swap 513MiB 4609MiB
parted $DISK2 -- mkpart primary linux-swap 513MiB 4609MiB

parted -a optimal $DISK1 -- mkpart primary 4609MiB 100%
parted -a optimal $DISK2 -- mkpart primary 4609MiB 100%

mkfs.fat -F 32 -n boot $DISK1-part1
mkfs.fat -F 32 -n boot $DISK2-part1

mkswap -L swap $DISK1-part2
mkswap -L swap $DISK2-part2

swapon $DISK1-part2
swapon $DISK2-part2

zpool create \
  -o ashift=12 \
  -o autotrim=on \
  -O acltype=posixacl \
  -O atime=off \
  -O compression=lz4 \
  -O dnodesize=auto \
  -O mountpoint=none \
  -O xattr=sa \
  -O encryption=on -O keyformat=passphrase -O keylocation=prompt \
  rpool mirror $DISK1-part3 $DISK2-part3

zfs create -o refreservation=10G -o mountpoint=none rpool/reserved

zfs create -o mountpoint=legacy rpool/root
zfs create -o mountpoint=legacy rpool/nix
zfs create -o mountpoint=legacy rpool/var
zfs create -o mountpoint=legacy rpool/home

mkdir /mnt/root
mount -t zfs zpool/root /mnt

mount /dev/$DISK1-part1 /mnt/boot

mkdir /mnt/nix /mnt/var /mnt/home
mount -t zfs rpool/nix /mnt/nix
mount -t zfs rpool/var /mnt/var
mount -t zfs rpool/home /mnt/home

nix-shell -p wget unzip
cd /mnt/boot
wget https://github.com/pftf/RPi4/releases/download/v1.35/RPi4_UEFI_Firmware_v1.35.zip
unzip RPi4_UEFI_Firmware_v1.35.zip
rm README.md
rm RPi4_UEFI_Firmware_v1.35.zip

# configure NixOS according to flake in local directory
nix-shell -p nixUnstable git
nixos-install --impure --flake '.#pi'

# configure NixOS according to flake from GitHub
nix-shell -p nixUnstable git
nixos-install --flake https://github.com/MarkusLohmayer/nix-config#pi

shutdown -h now
```

