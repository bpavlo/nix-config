{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./applications
    ./packages.nix
    ./fish.nix
    ./applications/aerospace.nix
  ];

  home.stateVersion = "25.11";

  manual.manpages.enable = false;

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    home-manager.enable = true;
  };

  services = {
    syncthing = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
    };
  };
}
