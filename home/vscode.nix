{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;
      [
        james-yu.latex-workshop
        mkhl.direnv
        vscodevim.vim
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "language-julia";
          publisher = "julialang";
          version = "1.54.2";
          sha256 = "9zNrSRRZpwk5rxephF5KCBvGYPz9LBHckqjoqj8q+NY=";
        }
      ];
  };
  home.shellAliases."code" = "codium";
}
