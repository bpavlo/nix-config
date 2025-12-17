{
  config,
  lib,
  pkgs,
  ...
}:

# Legacy home config for pvl user (uses zsh instead of fish)
# To be removed after macOS reinstall with pavlo user

{
  imports = [
    ./applications
    ./packages.nix
    ./zsh.nix
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
}
