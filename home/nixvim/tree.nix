{...}: {
  config = {
    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };
    maps.normal."<leader>e" = {
      action = ":Neotree action=focus reveal toggle<CR>";
      silent = true;
      desc = "file tree";
    };
  };
}
