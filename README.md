# nix-config

Nix flake containing
- [nix-darwin](https://github.com/LnL7/nix-darwin) system configuration
- [home-manager](https://github.com/nix-community/home-manager) user configuration
- [Neovim](https://github.com/neovim/neovim) configuration via [NixVim](https://github.com/nix-community/nixvim)


## Nix

Installation:

```
sh <(curl -L https://nixos.org/nix/install)
```

Documentation:
- [Nix language](https://nixos.org/manual/nix/stable/language)


## System configuration

Activation:

```
./switch darwin
```

Documentation:
- [nix-darwin](https://daiderd.com/nix-darwin/manual)


## User configuration

Activation:

```
./switch m_one_home
```

Documentation:
- [home-manager](https://nix-community.github.io/home-manager)


## Update flake lock file

```
nix flake update
```


## Further setup steps on macOS beyond Nix

### Add SSH key

```
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

### Homebrew

Installation:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install packages according to Brewfile:

```
brew bundle  --no-upgrade --cleanup
```

Install and upgrade all dependencies from the Brewfile:

```
brew bundle --cleanup
```


### Install keyboard layout (used with Kyria keyboard)

```
curl -O https://raw.githubusercontent.com/xv0x7c0/osx-us-altgr-intl/master/us-altgr-intl.keylayout
sudo mv us-altgr-intl.keylayout /Library/Keyboard\ Layouts
```


### Install Apple Rosetta (x86 emulation on arm64)

```
softwareupdate --install-rosetta
```
