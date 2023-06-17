{pkgs, ...}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      leap-nvim
    ];
    extraConfigLua = ''
      require("leap").add_default_mappings()
    '';
  };
}
