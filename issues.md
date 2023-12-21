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
