{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zellij = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      themes.solarized-osaka = {
        fg = "#839496";
        bg = "#00141a";
        black = "#073642";
        red = "#dc322f";
        green = "#859900";
        yellow = "#b58900";
        blue = "#268bd2";
        magenta = "#d33682";
        cyan = "#2aa198";
        white = "#eee8d5";
        orange = "#cb4b16";
      };
      theme = "solarized-osaka";
      pane_frames = false;
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
      default_layout = "compact";
    };
  };
}
