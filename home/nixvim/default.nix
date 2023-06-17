{
  pkgs,
  # helpers,
  ...
}: {
  imports = [
    ./autocmd.nix
    ./barbar.nix
    ./cmp.nix
    ./comment.nix
    ./gitsigns.nix
    ./colorscheme.nix
    ./indentline.nix
    ./keymaps.nix
    ./leap.nix
    ./lsp.nix
    ./lualine.nix
    ./options.nix
    ./project.nix
    ./sort.nix
    ./telescope.nix
    ./tmux.nix
    ./toggleterm.nix
    ./tree.nix
    ./treesitter.nix
    ./which-key.nix
  ];
  config = {
    luaLoader.enable = true;

    plugins = {
      # nvim-colorizer.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      mkdir-nvim
    ];
  };
}
