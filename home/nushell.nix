{config, ...}: {
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let $config = {
        table_mode: rounded
        use_ls_colors: true
        edit_mode: vi
      }
    '';
    inherit (config.home) shellAliases;
  };

  programs.starship.enableNushellIntegration = true;
}
