# pi

NixOS on a Raspberry Pi 4B with [UEFI firmware](https://github.com/pftf/RPi4) and mainline kernel

## Prepare installation medium

Download NixOS 23.11 SD-card image for `aarch64` CPUs:
https://hydra.nixos.org/job/nixos/release-23.11/nixos.sd_image.aarch64-linux

Decompress image:

```bash
nix-shell -p zstd --run "unzstd nixos-sd-image-23.11.2082.d02ffbbe834b-aarch64-linux.img.zst"
```

Flash to USB pen drive (use `dd` or GUI tool such as 'balena etcher').


## Installation

Start SSH server and set root password:

```bash
sudo systemctl start sshd
sudo passwd
```


Install NixOS:

```bash
ssh root@192.168.0.3

nix-shell -p wget unzip git

git clone https://github.com/MarkusLohmayer/nix-config
cd nix-config # make sure to comment out indicated modules in ./machines/pi/configuration.nix

nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko ./machines/pi/disko.nix

cd /mnt/boot
wget https://github.com/pftf/RPi4/releases/download/v1.35/RPi4_UEFI_Firmware_v1.35.zip
unzip RPi4_UEFI_Firmware_v1.35.zip
rm README.md
rm RPi4_UEFI_Firmware_v1.35.zip

cd ~/nix-config
nixos-install --root /mnt --impure --flake '.#pi'

shutdown -h now
```


Copy SSH keys to freshly installed server:

```bash
ssh-copy-id markus@192.168.0.3
scp ~/.ssh/id_rsa* ~/.ssh/id_ed25519* markus@192.168.0.3:.ssh/
```


Download nix-config and setup home on freshly installed server:

```bash
ssh markus@192.168.0.3

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
git clone git@github.com:MarkusLohmayer/nix-config.git
cd nix-config
mkdir -p ~/.local/state/nix/profiles
./switch pi_markus
```


## Secret management with `sops-nix`

### Setup admin and server keys

Create a personal (admin) SSH key without passphrase:

```bash
ssh-keygen -t ed25519 -C markus.lohmayer@gmail.com
```

Convert SSH key into an age key to encrypt secrets:

```bash
mkdir -p ~/.config/sops/age
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"
```

Obtain corresponding public key (for `.sops.yaml` file)

```bash
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"
```

Convert SSH machine key of server into an age key to decrypt secrets (for `.sops.yaml` file):

```bash
nix-shell -p ssh-to-age --run "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age"
```

### Add or edit secrets

```bash
mkdir -p ./secrets
nix run nixpkgs#sops ./secrets/secrets.yaml
```
