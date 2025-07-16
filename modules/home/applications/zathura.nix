{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.zathura = {
    enable = true;
    options = {
      font = "FiraCode Nerd Font 16";
    };
  };
}
