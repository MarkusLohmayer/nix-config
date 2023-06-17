# NixOS setup as a UTM virtual machine

Download NixOS 23.05 for `aarch64` CPUs:
https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-aarch64-linux.iso

- "Create a New Virtual Machine."
- "Virtualize"
- "Other"
- Select downloaded "Boot ISO Image"
- follow the remaining steps
- start the machine


```bash
passwd
ip a
```


```bash
ssh nixos@192.168.64.2

sudo -i

# create GPT partition table
parted /dev/vda -- mklabel gpt

# create primary partition,
# leaving some space at start and end of disk
parted /dev/vda -- mkpart primary 512MB -8GB

# create swap partition on the remaining 8GB
parted /dev/vda -- mkpart primary linux-swap -8GiB 100%

# create boot parition on the first 512MB
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 3 esp on

# format all three partitions
mkfs.ext4 -L nixos /dev/vda1
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda3

# mount partitions for installation
mount /dev/disk/by-label/nixos /mnt
swapon /dev/vda2
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

# configure NixOS according to flake in local directory
nix-shell -p nixUnstable git
nixos-install --impure --flake '.#nixos'

# configure NixOS according to flake from GitHub
nix-shell -p nixUnstable git
nixos-install --flake https://github.com/MarkusLohmayer/nix-config#nixos

shutdown -h now
```

