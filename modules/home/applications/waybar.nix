{ pkgs, lib, ... }:

{
  programs.waybar = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
  };
}
