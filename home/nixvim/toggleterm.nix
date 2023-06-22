{...}: {
  config = {
    plugins.toggleterm = {
      enable = true;
      openMapping = "<c-\\>";
      direction = "float";
      floatOpts.border = "curved";
    };
  };
}
