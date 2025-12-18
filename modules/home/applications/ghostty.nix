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
        "super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"
      ];
      window-decoration = "none";
    };
  };
}
