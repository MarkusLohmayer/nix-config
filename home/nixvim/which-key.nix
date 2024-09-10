{...}: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        icons = {
          group = "";
          separator = "";
        };
        disable.ft = ["TelescopePrompt"];
        win.border = "single";
      };
    };
  };
}
