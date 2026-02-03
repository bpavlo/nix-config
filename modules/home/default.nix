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
    ./ssh.nix
    ./applications/aerospace.nix
  ];

  home.stateVersion = "25.11";

  manual.manpages.enable = false;

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
  };

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
