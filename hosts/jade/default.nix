{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
    ../../users/pvl.nix
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
    computerName = "jade";
    hostName = "jade";
  };

  nix.enable = false;

  system = {
    primaryUser = "pvl";
    stateVersion = 6;
  };
}
