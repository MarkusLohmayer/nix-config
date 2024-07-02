{...}: {
  config = {
    plugins = {
      treesitter = {
        enable = true;
        nixGrammars = true; # install grammars with Nix
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
        nixvimInjections = true; # Lua in extraConfigLua

        indent = true;
        folding = false;
      };

      rainbow-delimiters.enable = true;
    };
  };
}
