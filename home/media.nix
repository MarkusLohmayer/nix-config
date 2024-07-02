{pkgs, ...}: {
  home.packages = with pkgs; [
    # convert audio and video
    ffmpeg

    audacity

    # download video (or audio) from various streaming sites
    yt-dlp

    # TUI-based music player
    termusic
  ];

  home.shellAliases."audio-dl" = "yt-dlp -i --extract-audio --audio-format mp3 --audio-quality 0";
}
