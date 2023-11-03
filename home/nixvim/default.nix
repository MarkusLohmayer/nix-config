{pkgs, ...}: {
  imports = [
    ./autocmd.nix
    ./barbar.nix
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./gitsigns.nix
    ./indentline.nix
    ./keymaps.nix
    ./lsp.nix
    ./lualine.nix
    ./options.nix
    ./project.nix
    ./sort.nix
    ./telescope.nix
    ./tmux.nix
    ./tree.nix
    ./treesitter.nix
    ./which-key.nix
  ];
  config = {
    luaLoader.enable = true;

    plugins = {
      leap.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      mkdir-nvim
    ];
  };
}
