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
    keymaps = [
      {
        options.desc = "file tree";
        key = "<leader>e";
        action = ":Neotree action=focus reveal toggle<cr>";
        options.silent = true;
      }
    ];
  };
}
