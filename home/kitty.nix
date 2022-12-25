{ config, pkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    # https://sw.kovidgoyal.net/kitty/conf/
    settings = {
      # font settings
      font_family = "JuliaMono";
      font_size = 18;
      # adjust_line_height = "140%";
      # disable ligatures when cursor is on them
      disable_ligatures = "cursor";

      # window settings
      hide_window_decorations = "titlebar-only";
      window_padding_width = "10";

      # tab bar settings
      tab_bar_edge = "top";
      tab_bar_style = "separator";
      tab_separator = " | ";
      tab_title_template = "{index}: {title}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # keyboard settings
      # use the left option key as an alt key and
      # leave the right option key for Unicode input
      macos_option_as_alt = "left";

      # mouse settings
      mouse_hide_wait = "3.0";

      # bell settings
      enable_audio_bell = "no";
      visual_bell_duration = "0.0";
      bell_on_tab = "🔔 ";
    };
    keybindings = {
      # disable edit config file
      "cmd+," = "no_op";
    };
  };
}
