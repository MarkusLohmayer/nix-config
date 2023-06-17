{
  pkgs,
  # helpers,
  ...
}: {
  config = {
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
        globalstatus = true;
        iconsEnabled = true;
        theme = "catppuccin";
        componentSeparators = {
          left = "";
          right = "";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
        alwaysDivideMiddle = true;
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = ["diagnostics"];
          lualine_x = ["diff" "spaces" "encoding" "filetype"];
          lualine_y = ["location"];
          lualine_z = ["progress"];
        };
      };
    };
  };
}
