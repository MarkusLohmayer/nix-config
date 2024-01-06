# pi

NixOS on a Raspberry Pi 4B with [UEFI firmware](https://github.com/pftf/RPi4) and mainline kernel

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

ls $DISK1
ls $DISK2

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
  rpool mirror $DISK1-part3 $DISK2-part3

zfs create -o refreservation=10G -o mountpoint=none rpool/reserved

zfs create rpool/nix
zfs create rpool/persist
zfs create rpool/home

mount -t tmpfs none /mnt

mkdir /mnt/boot
mount $DISK1-part1 /mnt/boot

mkdir /mnt/nix /mnt/persist /mnt/home
mount -t zfs -o zfsutil rpool/nix /mnt/nix
mount -t zfs -o zfsutil rpool/persist /mnt/persist
mount -t zfs -o zfsutil rpool/home /mnt/home

nix-shell -p wget unzip
cd /mnt/boot
wget https://github.com/pftf/RPi4/releases/download/v1.35/RPi4_UEFI_Firmware_v1.35.zip
unzip RPi4_UEFI_Firmware_v1.35.zip
rm README.md
rm RPi4_UEFI_Firmware_v1.35.zip

# install and configure NixOS according to flake in local directory
nix-shell -p nixUnstable git
git clone https://github.com/MarkusLohmayer/nix-config
cd nix-config
nixos-install --impure --flake '.#pi'

shutdown -h now
```

Copy SSH keys to freshly installed server:

```bash
ssh-copy-id markus@192.168.0.3
scp ~/.ssh/id_rsa* ~/.ssh/id_ed25519* markus@192.168.0.3:.ssh/
```

Download nix-config and setup home on freshly installed server:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
git clone git@github.com:MarkusLohmayer/nix-config.git
cd nix-config
mkdir -p ~/.local/state/nix/profiles
./switch pi_markus
```

Secret management with `sops-nix`:

```bash
# create a personal SSH key without passphrase
ssh-keygen -t ed25519 -C markus.lohmayer@gmail.com

# convert SSH key into an age key to encrypt secrets
mkdir -p ~/.config/sops/age
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"

# obtain corresponding public key (for `.sops.yaml` file)
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"

# convert SSH machine key of server into an age key to decrypt secrets (for `.sops.yaml` file)
nix-shell -p ssh-to-age --run "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age"

# add/edit secrets
mkdir -p ./secrets
nix run nixpkgs#sops ./secrets/secrets.yaml
```
