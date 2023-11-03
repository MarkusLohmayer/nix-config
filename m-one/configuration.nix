# https://github.com/LnL7/nix-darwin
# https://daiderd.com/nix-darwin/manual/
# https://github.com/LnL7/nix-darwin/blob/master/modules/examples/lnl.nix
{
  pkgs,
  lib,
  ...
}: {
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "@admin"
      ];
      auto-optimise-store = false;
    };
    extraOptions =
      ''
        experimental-features = nix-command flakes
      ''
      + lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
    configureBuildUsers = true;
  };

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  environment.variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      julia-mono
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "Meslo"];})
    ];
  };

  # keyboard settings
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # trackpad settings
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = false;

  # use extended save dialog by default (without clicking on the triangle)
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  # use extended print dialog by default
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  # Finder settings
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  # don't warn when changing the file extension
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  # set default search scope to current folder
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
  # set default view to list
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;

  # Dock settings
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.tilesize = 50;
  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.15;
  system.defaults.dock.show-recents = true;
  # show icons of hidden applications as translucent
  system.defaults.dock.showhidden = true;
  # indicate running applications
  system.defaults.dock.show-process-indicators = true;
  # don't automatically rearrange spaces on most recent use
  system.defaults.dock.mru-spaces = false;

  system.defaults.universalaccess.reduceTransparency = true;
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;

  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;
}
