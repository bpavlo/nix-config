{ pkgs, lib, ... }:

{
  imports = [
    ./home-common.nix
    ../../modules/home/zsh.nix
    ../../modules/home/applications/aerospace.nix
  ];

  home = {
    stateVersion = "25.05";
  };
}