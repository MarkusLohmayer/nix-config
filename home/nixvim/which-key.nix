{...}: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      disable.filetypes = ["TelescopePrompt"];
      icons = {
        group = "";
        separator = "";
      };
      window.border = "single";
    };
  };
}
