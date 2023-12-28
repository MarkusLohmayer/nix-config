# m-one

## Nix

Installation:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

Documentation:
- [Nix language](https://nixos.org/manual/nix/stable/language)


## System configuration

Activation:

```bash
./switch m_one
```

Documentation:
- [nix-darwin](https://daiderd.com/nix-darwin/manual)


## User configuration

Activation:

```bash
./switch m_one_markus
```

Documentation:
- [home-manager](https://nix-community.github.io/home-manager)


## Update flake lock file

```bash
nix flake update
```


## Further setup steps on macOS beyond Nix

### Add SSH key

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

### Homebrew

Installation:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install packages according to Brewfile:

```bash
brew bundle  --no-upgrade --cleanup
```

Install and upgrade all dependencies from the Brewfile:

```bash
brew bundle --cleanup
```


### Install keyboard layout (used with Kyria keyboard)

```bash
curl -O https://raw.githubusercontent.com/xv0x7c0/osx-us-altgr-intl/master/us-altgr-intl.keylayout
sudo mv us-altgr-intl.keylayout /Library/Keyboard\ Layouts
```


### Install Apple Rosetta (x86 emulation on arm64)

```bash
softwareupdate --install-rosetta
```
