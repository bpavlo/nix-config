{ pkgs, lib, ... }:

{
  imports = [
    ../../modules/home/applications
  ];

  manual.manpages.enable = false;

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    home-manager.enable = true;
  };
}