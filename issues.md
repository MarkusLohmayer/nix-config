# issues solved by manual intervention

## issue with Nix setup on aarch64-darwin

`./setup-system.sh` failed on fresh `aarch64-darwin` system.
Using the following `/etc/nix/nix.conf` file to run `./setup-system.sh` for the first time resolved the problem.

```
build-users-group = nixbld

substituters        = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=

system = x86_64-darwin
extra-platforms = x86_64-darwin aarch64-darwin

sandbox = false
extra-sandbox-paths = /System/Library/Frameworks /System/Library/PrivateFrameworks /usr/lib /private/tmp /private/var/tmp /usr/bin/env
experimental-features = nix-command
extra-experimental-features = flakes
```

## tput: unknown terminal "xterm-kitty"

```
kitty +kitten ssh your.remote.server
```


## tput: unknown terminal "tmux-256color"

```
brew install ncurses
/usr/local/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
tic -xe tmux-256color tmux-256color.info
infocmp tmux-256color | head
```
