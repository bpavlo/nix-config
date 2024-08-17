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
        foreground = "#839395",
        background = "#001419",
        cursor_bg = "#fdf5e2",
        cursor_border = "#fdf5e2",
        cursor_fg = "#001419",
        selection_bg = "#fdf5e2",
        selection_fg = "#001419",
        ansi = {"#001419", "#db302d", "#849900", "#b28500", "#268bd3", "#d23681", "#29a298", "#ede7d3"},
        brights = {"#002c38", "#db302d", "#849900", "#b28500", "#268bd3", "#d23681", "#29a298", "#839395"},
        tab_bar = {
            inactive_tab_edge = "#002c38",
            background = "#001419",
            active_tab = {
                fg_color = "#839395",
                bg_color = "#001419",
            },
            inactive_tab = {
                bg_color = "#002c38",
                fg_color = "#839395",
            },
            inactive_tab_hover = {
                bg_color = "#002c38",
                fg_color = "#839395",
            },
            new_tab_hover = {
                fg_color = "#002c38",
                bg_color = "#839395",
            },
            new_tab = {
                fg_color = "#839395",
                bg_color = "#001419",
            },
        },
    }
      return config
    '';
  };
}
