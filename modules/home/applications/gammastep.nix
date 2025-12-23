{ pkgs, lib, ... }:

{
  services.gammastep = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    provider = "geoclue2";

    temperature = {
      day = 6500;
      night = 4000;
    };

    settings = {
      general = {
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
