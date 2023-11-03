{pkgs, ...}: {
  # https://nix-community.github.io/home-manager/options.html

  home = {
    stateVersion = "22.05";
    username = "markus";
    homeDirectory = "/Users/markus";
  };

  home.packages = with pkgs; [
    # convert files from one markup format into another
    pandoc

    # convert audio and video
    ffmpeg

    # download video (or audio) from various streaming sites
    yt-dlp
  ];

  home.shellAliases."audio-dl" = "yt-dlp -i --extract-audio --audio-format mp3 --audio-quality 0";
}
