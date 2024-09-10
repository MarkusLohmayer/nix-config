{...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensureInstalled = [
            "bash"
            "c"
            "c++"
            "haskell"
            "html"
            "julia"
            "latex"
            "lua"
            "markdown"
            "nix"
            "python"
            "toml"
            "yaml"
          ];
          indent.enable = true;
        };
      };
      rainbow-delimiters.enable = true;
    };
  };
}
