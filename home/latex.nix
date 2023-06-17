{pkgs, ...}: {
  home.packages = with pkgs; [
    texlive.combined.scheme-full

    pympress
  ];

  xdg.configFile."latexmk/latexmkrc".text = ''
    # generate a pdf version of the document using pdflatex
    # equivalent to `latexmk -pdflatex`
    $pdf_mode = 1;
    $pdflatex="pdflatex -synctex=1 -interaction=nonstopmode";

    # or generate a pdf version (and an xdv version) of the document using xelatex
    # equivalent to `latexmk -pdfxe` or `latexmk -xelatex`
    # $pdf_mode = 5;

    # use BibTeX (and clean bbl files)
    $bibtex_use = 2;

    # file extensions to remove when cleaning (`latexmk -c`)
    # (should match with the LaTeX section in the global ignore file of Git)
    # TODO it seems not possible to remove *-eps-converted-to.pdf and *-blx.bib
    $clean_ext = 'aux bbl bcf blg fdb_latexmk fls glo ist nav nlo out ptc run.xml snm spl synctex(busy) toc upa xdv dvi';
  '';
}
