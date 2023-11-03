{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 0;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
      tmux-colors-solarized
      {
        plugin = tilish;
        extraConfig = ''
          set -g @tilish-navigator 'on'
          set -g @tilish-default 'main-horizontal'
        '';
      }
    ];
    extraConfig = ''
      # vi key bindings for copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      set -g status-right '#h #(TZ="UTC" date +%%H:%%M) UTC'
    '';
  };

  home.shellAliases = {
    ta = "tmux attach -t";
    tad = "tmux attach -d -t";
    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
    tl = "tmux list-sessions";
    ts = "tmux new-session -s";
  };
}
