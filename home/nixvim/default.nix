# https://github.com/nix-community/nixvim
# https://nix-community.github.io/nixvim/
{pkgs, nixvim, ...}: {
  imports = [
    nixvim.homeManagerModules.nixvim
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

  programs.nixvim = {
    enable = true;

    luaLoader.enable = true;

    plugins = {
      leap.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      mkdir-nvim
    ];

    opts.spell = true;
    opts.spelllang = "en_us,de";
  };

  home.sessionVariables."EDITOR" = "nvim";
  home.shellAliases."v" = "nvim";
}
