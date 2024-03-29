{...}: {
  programs.git = {
    enable = true;
    userName = "Markus Lohmayer";
    userEmail = "markus.lohmayer@gmail.com";
    lfs.enable = true;
    extraConfig = {
      github.user = "MarkusLohmayer";

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
        features = "decorations line-numbers";
        navigate = true; # support n and N
        side-by-side = true;
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

  home.shellAliases = {
    g = "git";

    gst = "git status";

    glg = "git log --name-status";
    glgg = "git log --graph";
    glo = "git log --oneline --decorate";

    gd = "git diff";
    gds = "git diff --staged";

    ga = "git add";
    gaa = "git add --all";
    gap = "git add --patch";

    gmv = "git mv";
    grm = "git rm";

    gc = "git commit -v";
    gcmsg = "git commit -m";
    "gc!" = "git commit -v --amend";

    gf = "git fetch";

    gl = "git pull";
    glr = "git pull --rebase";

    gp = "git push";
    "gpf!" = "git push --force";

    gb = "git branch";
    gba = "git branch -a";
    gbd = "git branch -d";
    gbD = "git branch -D";

    gsw = "git switch";
    gswm = "git switch $(git_main_branch)";
    gswd = "git switch $(git_develop_branch)";
    gswc = "git switch --create";

    grb = "git rebase";
    grbi = "git rebase -i";
    grbc = "git rebase --continue";
    grba = "git rebase --abort";
    grbm = "git rebase $(git_main_branch)";
    grbd = "git rebase $(git_develop_branch)";
    grbom = "git rebase origin/$(git_main_branch)";
    grbod = "git rebase origin/$(git_develop_branch)";

    gm = "git merge";

    gco = "git checkout";
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "white" "bold" ];
        inactiveBorderColor = [ "white" ];
        selectedLineBgColor = [ "reverse" "white" ];
      };
    };
  };
  home.shellAliases."lg" = "lazygit";
}
