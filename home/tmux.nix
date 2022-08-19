{ config, pkgs, libs, ...}:
{

  home.packages = with pkgs; [
    tmux
  ];

  # reload configuration and install plugins: prefix + I
  # update plugins: prefix + U
  # uninstall plugins not listed below: prefix + alt + u

  xdg.configFile."tmux/tmux.conf".text = ''
    # tmux plugin manager
    set -g @plugin 'tmux-plugins/tpm'
    
    # basic tmux settings everyone can agree on
    set -g @plugin 'tmux-plugins/tmux-sensible'
    
    # persists tmux environment across system restarts
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    # continuous saving, automatic restore
    set -g @plugin 'tmux-plugins/tmux-continuum'
    # automatically restore tmux sessions after restart
    set -g @continuum-restore 'on'
    
    # color theme
    set -g @plugin 'seebi/tmux-colors-solarized'
    
    # tmux keybindings similar to i3
    set -g @plugin 'jabirali/tmux-tilish'
    # seamlessly navigate between tmux panes and vim splits
    set -g @tilish-navigator 'on'
    # main-horizontal, even-vertical, main-vertical, even-horizontal, tiled
    set -g @tilish-default 'tiled'
    
    # install tpm if not installed yet
    if "test ! -d ~/.tmux/plugins/tpm" \
       "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
    
    # activate the plugins
    run -b '~/.tmux/plugins/tpm/tpm'
    
    # remap tmux prefix from 'C-b' to 'C-a'
    unbind C-b
    set-option -g prefix C-a
    bind-key C-a send-prefix
    
    # start numbering windows at 1 
    set -g base-index 1
    
    # splits (like in vim)
    # open panes in current directory -c
    # v (side-by-side)
    bind-key v split-window -h -c '#{pane_current_path}'
    # s (top-below)
    bind-key s split-window -v -c '#{pane_current_path}'
    
    # status field
    set -g status-right '#h #(TZ="UTC" date +%%H:%%M) UTC'
    
    # vi key bindings for copy mode
    # `[` (enter mode) , `<Enter>` (leave mode)
    # https://sanctum.geek.nz/arabesque/vi-mode-in-tmux/
    set-window-option -g mode-keys vi
    bind-key -T copy-mode-vi 'v' send -X begin-selection
    bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    
    # activate mouse mode
    set -g mouse on
  '';

}
