{...}: {
  programs.nixvim = {
    plugins.project-nvim = {
      enable = true;
      enableTelescope = true;
      detectionMethods = [ "pattern" ];
      patterns = [ ".git" ];
    };
  };
}
