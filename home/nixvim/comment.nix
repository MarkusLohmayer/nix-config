{...}: {
  programs.nixvim = {
    plugins.comment = {
      enable = true;
      settings = {
        mappings = {
          basic = true;
          extra = true;
        };
      };
    };
  };
}
