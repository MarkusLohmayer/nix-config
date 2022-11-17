# nix-config

Nix flake containing
- [nix-darwin](https://github.com/LnL7/nix-darwin) system configuration
- [home-manager](https://github.com/nix-community/home-manager) user configuration


## Installation

```
sh <(curl -L https://nixos.org/nix/install)
./switch darwin
./switch m_one_home
```

Further steps unrelated to Nix:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle
```

```
curl -O https://raw.githubusercontent.com/xv0x7c0/osx-us-altgr-intl/master/us-altgr-intl.keylayout
sudo mv us-altgr-intl.keylayout /Library/Keyboard\ Layouts
```

```
softwareupdate --install-rosetta
```

```
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```


## Related documentation

- [Nix language](https://nixos.org/manual/nix/stable/language)
- [home-manager](https://nix-community.github.io/home-manager)
- [nix-darwin](https://daiderd.com/nix-darwin/manual)
