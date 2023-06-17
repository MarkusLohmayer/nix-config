{...}: {
  config = {
    plugins.project-nvim = {
      enable = true;
      detectionMethods = [ "pattern" ];
      patterns = [ ".git" ];
    };
  };
}
