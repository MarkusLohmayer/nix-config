{pkgs-stable, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs-stable.vscodium;
    extensions = with pkgs-stable.vscode-extensions;
      [
        james-yu.latex-workshop
        julialang.language-julia
        mkhl.direnv
        vscodevim.vim
        yzhang.markdown-all-in-one
      # ]
      # ++ pkgs-stable.vscode-utils.extensionsFromVscodeMarketplace [
      #   {
      #     name = "language-julia";
      #     publisher = "julialang";
      #     version = "1.54.2";
      #     sha256 = "9zNrSRRZpwk5rxephF5KCBvGYPz9LBHckqjoqj8q+NY=";
      #   }
      ];
  };
  home.shellAliases."code" = "codium";
}
