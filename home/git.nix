{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Markus Lohmayer";
    userEmail = "markus.lohmayer@gmail.com";
    lfs.enable = true;
    extraConfig = {
      github.user = "MarkusLohmayer";

      # set global gitignore file:
      # core.excludesfile = "~/.gitignore_global";

      core.autocrlf = false;
      core.eol = "lf";

      init.defaultBranch = "main";

      # by default only use fast-forward merge
      pull.ff = "only";

      # automatically push tags to remote
      push.followTags = true;

      status.submodulesummary = 1;

      diff.submodule = "log";
    };
    delta = {
      enable = true;
      options = {
        features = "decorations unobtrusive-line-numbers";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          commit-style = "raw";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
          hunk-header-style = "file line-number syntax";
          hunk-header-decoration-style = "blue box";
          hunk-header-file-style = "red";
          hunk-header-line-number-style = "#067a00";
        };
        unobtrusive-line-numbers = {
          line-numbers = true;
          line-numbers-minus-style = "red";
          line-numbers-plus-style = "green";
          line-numbers-left-format = "{nm:>4}┊";
          line-numbers-right-format = "{np:>4}┊";
          line-numbers-left-style = "red";
          line-numbers-right-style = "green";
        };
      };
    };
    ignores = [
      # Python
      "*.pyc"
      "*.pyo"
      ".ipynb_checkpoints/"
      "*.egg-info/"
      ".eggs/"
      "venv/"


      # Matlab, Simulink, Octave
      "*.asv"
      "*.m~"
      "*.mex*"
      "*.mlappinstall"
      "*.mltbx"
      "helpsearch*/"
      "slprj/"
      "sccprj/"
      "codegen/"
      "*.slxc"
      "*.autosave"
      "octave-workspace"


      # LaTeX
      "*.aux"
      "*.bbl"
      "*.bcf"
      "*.blg"
      "*.cut"
      "*.fdb_latexmk"
      "*.fls"
      "*.nav"
      "*.nlo"
      "*.out"
      "*.ptc"
      "*.run.xml"
      "*.snm"
      "*.spl"
      "*.toc"
      "*.upa"
      "*.xdv"
      "*.dvi"
      "*-blx.bib"
      "*-eps-converted-to.pdf"
      "*.synctex(busy)"

      # archive files
      "*.7z"
      "*.gz"
      "*.rar"
      "*.tar"
      "*.zip"

      # log files
      "*.log"

      # database files
      "*.sqlite"

      # macOS
      ".DS_Store"

      # Vim
      "*.swp"
      "tags"
      "tags.lock"
      "tags.temp"

      # Visual Studio Code
      ".vscode/*"
      "*.code-workspace"

      # JetBrains IDEs
      ".idea/*"
    ];
  };


  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
