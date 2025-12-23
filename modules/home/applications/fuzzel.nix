{ pkgs, lib, ... }:

{
  programs.fuzzel = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = {
      main = {
        font = "Noto Sans:size=12";
        dpi-aware = "yes";
        icon-theme = "Adwaita";
        layer = "overlay";
        width = 40;
        horizontal-pad = 20;
        vertical-pad = 10;
        inner-pad = 10;
      };

      colors = {
        background = "111111ff";
        text = "828282ff";
        match = "aaaaaaff";
        selection = "191919ff";
        selection-text = "aaaaaaff";
        selection-match = "ffffffff";
        border = "3c3c3cff";
      };

      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
