{...}: {
  config = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        dim_inactive = {
          enabled = true;
          percentage = 0.25;
        };
        custom_highlights = ''
          function(colors)
            return {
              Comment = { fg = colors.flamingo },
              WinSeparator = { fg = colors.flamingo },
            }
          end
        '';
      };
    };
  };
}
