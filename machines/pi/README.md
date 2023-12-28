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

systemctl start sshd
passwd

DISK1=/dev/disk/by-id/usb-Micron_CT2000X9PROSSD9_2325E8C44F0A-0:0
DISK2=/dev/disk/by-id/usb-Micron_CT2000X9PROSSD9_2338E8C498CC-0:0

wipefs -a $DISK1
wipefs -a $DISK2

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

zfs create rpool/root
zfs create rpool/nix
zfs create rpool/var
zfs create rpool/home
zfs create rpool/home/markus

mount -t zfs -o zfsutil rpool/root /mnt

mkdir /mnt/boot
mount $DISK1-part1 /mnt/boot

mkdir /mnt/nix /mnt/var /mnt/home
mount -t zfs -o zfsutil rpool/nix /mnt/nix
mount -t zfs -o zfsutil rpool/var /mnt/var
mount -t zfs -o zfsutil rpool/home /mnt/home

nix-shell -p wget unzip
cd /mnt/boot
wget https://github.com/pftf/RPi4/releases/download/v1.35/RPi4_UEFI_Firmware_v1.35.zip
unzip RPi4_UEFI_Firmware_v1.35.zip
rm README.md
rm RPi4_UEFI_Firmware_v1.35.zip

# configure NixOS according to flake in local directory
nix-shell -p nixUnstable git
nixos-generate-config --root /mnt
cd /mnt/etc/nixos/
git clone https://github.com/MarkusLohmayer
# copy generated hardware-configuration.nix to machines/pi/
# and add `options = [ "zfsutil" ]` to every ZFS filesystem
nixos-install --impure --flake '.#pi'

shutdown -h now
```

```bash
passwd markus
cd /etc/nixos/
rm configuration.nix hardware-configuration.nix
mv nix-config /home/markus/
```

```bash
ssh-copy-id markus@192.168.0.3
scp ~/.ssh/id_rsa* markus@192.168.0.3:.ssh/
```

```bash
sudo chown -R markus:users nix-config
chmod -R go-rwx nix-config
cd nix-config
mkdir -p ~/.local/state/nix/profiles
./switch pi_markus
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

