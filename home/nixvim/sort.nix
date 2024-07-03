{pkgs, ...}: {
  programs.nixvim = {
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
    keymaps = [
      {
        options.desc = "sort (c.i.)";
        mode = ["n" "v"];
        key = "gs";
        action = "<esc><cmd>Sort i<cr>";
        options.silent = true;
      }
      {
        options.desc = "sort (c.s.)";
        mode = ["n" "v"];
        key = "gS";
        action = "<esc><cmd>Sort<cr>";
        options.silent = true;
      }
    ];
  };
}
