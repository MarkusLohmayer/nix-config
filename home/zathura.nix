{ config, pkgs, libs, ...}:
{

  programs.zathura = {
    enable = true;
    extraConfig = ''
      map r reload
      map R rotate
      map p print
      map i recolor

      map > zoom in
      map < zoom out
      map F toggle_fullscreen

      map [fullscreen] > zoom in
      map [fullscreen] < zoom out
      map [fullscreen] F toggle_fullscreen

      set selection-clipboard clipboard

      set adjust-open "best-fit"

      set pages-per-row 1

      set page-padding 10

      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      set zoom-min 10

      set guioptions ""

      set font "FiraCode 15"

      set notification-error-bg       "#586e75" # base01
      set notification-error-fg       "#dc322f" # red
      set notification-warning-bg     "#586e75" # base01
      set notification-warning-fg     "#dc322f" # red
      set notification-bg             "#586e75" # base01
      set notification-fg             "#b58900" # yellow

      set completion-group-bg         "#002b36" # base03
      set completion-group-fg         "#839496" # base0
      set completion-bg               "#073642" # base02
      set completion-fg               "#93a1a1" # base1
      set completion-highlight-bg     "#586e75" # base01
      set completion-highlight-fg     "#eee8d5" # base2

      set index-bg                    "#073642" # base02
      set index-fg                    "#93a1a1" # base1
      set index-active-bg             "#586e75" # base01
      set index-active-fg             "#eee8d5" # base2

      set inputbar-bg                 "#586e75" # base01
      set inputbar-fg                 "#eee8d5" # base2

      set statusbar-bg                "#073642" # base02
      set statusbar-fg                "#93a1a1" # base1

      set highlight-color             "#657b83" # base00
      set highlight-active-color      "#268bd2" # blue

      set default-bg                  "#073642" # base02
      set default-fg                  "#93a1a1" # base1
      set render-loading              true
      set render-loading-fg           "#073642" # base02
      set render-loading-bg           "#073642" # base02

      set recolor                     false
      set recolor-lightcolor          "#073642" # base02
      set recolor-darkcolor           "#93a1a1" # base1
      set recolor-keephue             true

      set synctex true
    '';
  };
}
