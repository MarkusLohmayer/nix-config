{...}: {
  programs.tmate = {
    enable = true;
    extraConfig = ''
      set  -g base-index      1
      setw -g pane-base-index 1

      set -g status-keys vi
      set -g mode-keys   vi

      # rebind main key: C-a
      unbind C-b
      set -g prefix C-a
      bind -N "Send the prefix key through to the application" \
        a send-prefix
      bind C-a last-window

      set  -g mouse             on
      setw -g aggressive-resize on
      setw -g clock-mode-style  24
      set  -s escape-time       0
      set  -g history-limit     2000

      # vi key bindings for copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      set -g status-right '#(TZ="UTC" date +%%H:%%M) UTC'
    '';
  };
}
