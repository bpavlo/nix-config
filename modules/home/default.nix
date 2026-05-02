{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./applications
    ./packages.nix
    ./fish.nix
    ./tmux.nix
    ./ssh.nix
    ./applications/aerospace.nix
    inputs.zen-browser.homeModules.twilight

  ];

  home.stateVersion = "25.11";

  gtk.gtk4.theme = config.gtk.theme;

  manual.manpages.enable = false;

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    BROWSER = "zen-twilight";
    TERMINAL = "ghostty";
    TF_PLUGIN_CACHE_DIR = "$HOME/.terraform.d/plugin-cache";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    home-manager.enable = true;

    zen-browser = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
    };
  };

  services = {
    syncthing = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
    };
  };
}
