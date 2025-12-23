{ pkgs, lib, ... }:

{
  programs.wlogout = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
  };
}
