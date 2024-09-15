{...}: {
  programs.nixvim = {
    plugins.project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        detectionMethods = [ "pattern" ];
        patterns = [ ".git" ];
      };
    };
  };
}
