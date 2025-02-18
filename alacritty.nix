{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "Full";
        option_as_alt = "Both";
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font";
        };
        size = 20;
      };
      colors = {
        primary = {
          background = "#00141a";
          foreground = "#839496";
        };
        normal = {
          black = "#00141a";
          red = "#dc322f";
          green = "#849900";
          yellow = "#b28500";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
        };
        bright = {
          black = "#163848";
          red = "#f55350";
          green = "#b7f900";
          yellow = "#ffbf00";
          blue = "#46acf5";
          magenta = "#f254a0";
          cyan = "#2aeddd";
          white = "#fdf6e2";
        };
      };
    };
  };
}
