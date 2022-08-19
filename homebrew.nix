{ pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    taps = [
      "homebrew/cask"
    ];

    brews = [
      # move files and folders to trash
      "mosh"
      "trash"
    ];

    casks = [
      "adobe-acrobat-reader"
      "bitwarden"
      "firefox"
      "gimp"
      "iina"
      "jupyter-notebook-viewer"
      "latexit"
      "launchbar"
      "macs-fan-control"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-remote-desktop"
      "microsoft-teams"
      "microsoft-word"
      "obs"
      "obs-virtualcam"
      "omnifocus"
      "omnioutliner"
      "pdf-expert"
      "skim"
      "skype"
      "tor-browser"
      "visual-studio-code"
      "zoom"
    ];

    # masApps = {
    #   unsplash-wallpapers = 1284863847;
    # };
  };
}
