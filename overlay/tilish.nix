{
  fetchFromGitHub,
  pkgs,
}:
pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "tilish";
  version = "2023-09-20";
  src = fetchFromGitHub {
    owner = "jabirali";
    repo = "tmux-tilish";
    rev = "22f7920837d827dc6cb31143ea916afa677c24c1";
    sha256 = "wP3c+p/DM6ve7GUhi0QEzggct7NS4XUa78sVQFSKrfo=";
  };
}
