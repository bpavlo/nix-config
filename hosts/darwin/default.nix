{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/system.nix
    ../../users/pvl
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  users.users.pvl = {
    home = "/Users/pvl";
    shell = pkgs.zsh;
  };

  networking = {
    computerName = "darwin";
    hostName = "darwin";
  };

  # Disable nix management for Determinate Nix compatibility
  nix.enable = false;

  system = {
    primaryUser = "pvl";
    stateVersion = 6;
  };
}
