# Issues solved by manual intervention

## tput: unknown terminal "xterm-kitty"

```
kitty +kitten ssh your.remote.server
```


## tput: unknown terminal "tmux-256color"

```
brew install ncurses
/opt/homebrew/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
tic -xe tmux-256color tmux-256color.info
infocmp tmux-256color | head
```


## Neovim with VimTeX, zathura and SyncTeX on macOS

The communication between Neovim and zathura requires dbus.
So far, I have not spent enough time to setup dbus correctly using Nix.

```
brew install dbus
```

```
sudo vi /opt/homebrew/opt/dbus/share/dbus-1/session.conf
```

Change the value of `<auth><\auth>`
from `EXTERNAL`
to `DBUS_COOKIE_SHA1`.

```
brew services start dbus
```

Reboot the system.


## Julia setup

- install Julia manually from the [website](https://julialang.org/downloads/)
- configuration file is managed by home-manager
- manually add symlink to launch Julia from the terminal:

```
sudo rm -f /usr/local/bin/julia
sudo ln -s /Applications/Julia-1.9.app/Contents/Resources/julia/bin/julia /usr/local/bin/julia
```
