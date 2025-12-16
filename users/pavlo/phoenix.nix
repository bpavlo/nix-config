{ pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pavlo = import ./home-phoenix.nix;
  };
}