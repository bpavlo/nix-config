{ pkgs, ... }:

{
  imports = [
    ../../modules/home/applications
    ../../modules/home/packages.nix
    ../../modules/home/shell.nix
  ];
  
  manual.manpages.enable = false;
  
  home = {
    stateVersion = "25.05";
  };

  programs = {
    ghostty = {
      enable = false;
      enableZshIntegration = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox = {
      enable = false;
      package = pkgs.firefox-unwrapped;
    };
    home-manager = {
      enable = true;
    };
  };

  services = {
    syncthing = {
      enable = false;
    };
  };
}
