{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local config = {}

      config.font = wezterm.font("FiraCode Nerd Font")
      config.font_size = 16
      config.window_decorations = "RESIZE"
      config.window_frame = {
        font_size = 16,
      }
      config.colors = {
        foreground = "#839495",
        background = "#00141A",
        cursor_bg = "#FDF6E2",
        cursor_border = "#FDF6E2",
        cursor_fg = "#00141A",
        selection_bg = "#FDF6E2",
        selection_fg = "#00141A",
        ansi = {"#00141A", "#DC312E", "#859900", "#B38600", "#278BD3", "#D33682", "#2AA298", "#EDE7D4"},
        brights = {"#4c4c4c", "#F65351", "#B7FA00", "#FFBF00", "#47ADF5", "#F254A1", "#2BEEDE", "#FDF6E2"},
        tab_bar = {
          inactive_tab_edge = "#002D38",
          background = "#00141A",
          active_tab = {
            fg_color = "#839495",
            bg_color = "#00141A",
          },
          inactive_tab = {
            bg_color = "#002D38",
            fg_color = "#839495",
          },
          inactive_tab_hover = {
            bg_color = "#002D38",
            fg_color = "#839495",
          },
          new_tab_hover = {
            fg_color = "#002D38",
            bg_color = "#839495",
          },
          new_tab = {
            fg_color = "#839495",
            bg_color = "#00141A",
          },
        },
      }

      return config
    '';
  };
}
