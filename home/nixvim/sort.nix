{pkgs, ...}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      sort-nvim
    ];
    extraConfigLua = ''
      require("sort").setup {
        -- List of delimiters, in descending order of priority, to automatically sort on.
        delimiters = {
          ",",
          "|",
          ";",
          ":",
          "s", -- Space
          "t", -- Tab
        },
      }
    '';
    maps = {
      normal = {
        "gs" = {
          action = "<cmd>Sort i<cr>";
          silent = true;
          desc = "sort (c.i.)";
        };
        "gS" = {
          action = "<cmd>Sort<cr>";
          silent = true;
          desc = "sort (c.s.)";
        };
      };
      visual = {
        "gs" = {
          action = "<esc><cmd>Sort i<cr>";
          silent = true;
          desc = "sort (c.i.)";
        };
        "gS" = {
          action = "<esc><cmd>Sort<cr>";
          silent = true;
          desc = "sort (c.s.)";
        };
      };
    };
  };
}
