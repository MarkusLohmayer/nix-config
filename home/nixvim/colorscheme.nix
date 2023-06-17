{helpers, ...}: {
  config = {
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      background.dark = "mocha";
      dimInactive = {
        enabled = true;
        percentage = 0.25;
      };
      customHighlights = {
        Comment.fg = helpers.mkRaw "colors.flamingo";
        WinSeparator.fg = helpers.mkRaw "colors.flamingo";
      };
      # terminalColors = true;
      # disableItalic = false;
      # disableBold = false;
    };
  };
}
