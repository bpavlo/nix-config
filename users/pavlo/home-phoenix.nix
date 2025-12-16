{ pkgs, lib, ... }:

{
  imports = [
    ./home-common.nix
    ../../modules/home/fish.nix
    ../../modules/home/packages-nixos.nix
  ];

  home = {
    stateVersion = "25.11";
  };

  programs = {
    ghostty = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  services = {
    syncthing.enable = true;
  };
}