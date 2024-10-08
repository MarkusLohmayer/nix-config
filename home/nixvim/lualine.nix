{
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      (lualine-lsp-progress.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "WhoIsSethDaniel";
          repo = "lualine-lsp-progress.nvim";
          rev = "8e3161c17d62b485f5df08254cbe961704af300b";
          sha256 = "ARm7AW6hzHDbCD7fvGTT50dHDV+DuNfCHv7snRk365E=";
        };
      }))
    ];
    plugins = {
      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff"];
            lualine_c = ["diagnostics"];
            lualine_x = ["spaces" "encoding" "filetype"];
            lualine_y = ["location"];
            lualine_z = ["progress"];
          };
          alwaysDivideMiddle = true;
          componentSeparators = {
            left = "";
            right = "";
          };
          sectionSeparators = {
            left = "";
            right = "";
          };
          iconsEnabled = true;
          globalstatus = true;
          theme = "catppuccin";
        };
      };
    };
  };
}
