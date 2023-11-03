{pkgs, ...}: {
  programs.starship = {
    enable = true;
    # https://starship.rs/config/
    settings = {
      add_newline = true;

      git_branch = {symbol = "🌱 ";};
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_state = {
        format = "[($state($progress_current of $progress_total))]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = "🏳";
        ahead = "💨";
        behind = "😰";
        diverged = "😵";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++($count)](green)";
        renamed = "👅";
        deleted = "🗑️";
      };

      cmd_duration = {
        min_time = 500; # ms
        format = "[$duration]($style) ";
      };

      command_timeout = 1200;

      # if working directory is a package repository, show the version number
      # package.disabled = true;
    };
  };
}
