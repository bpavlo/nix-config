{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.ghostty = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 14;
      theme = "Black Metal (Mayhem)";
      window-padding-x = 10;
      window-padding-y = 10;
      keybind = [
        "ctrl+shift+w=close_tab"
      ];
      window-decoration = "none";
    };
  };
}
