{ pkgs, lib, ... }:

{
  services.mako = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

    settings = {
      # Monochrome color scheme
      background-color = "#111111";
      text-color = "#828282";
      border-color = "#3c3c3c";
      progress-color = "over #aaaaaa";

      # Layout
      width = 350;
      height = 150;
      margin = "10";
      padding = "15";
      border-size = 2;
      border-radius = 0;

      # Font
      font = "Noto Sans 12";

      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;
      layer = "overlay";
      anchor = "top-right";

      # Grouping
      group-by = "app-name";
      max-visible = 5;

      # Icons
      icons = true;
      max-icon-size = 48;
    };

    extraConfig = ''
      [urgency=low]
      border-color=#5d5d5d
      default-timeout=3000

      [urgency=normal]
      border-color=#828282
      default-timeout=5000

      [urgency=high]
      border-color=#aaaaaa
      background-color=#191919
      text-color=#aaaaaa
      default-timeout=0

      [category=mpris]
      default-timeout=3000
      group-by=category
    '';
  };
}
