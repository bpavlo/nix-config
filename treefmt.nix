# treefmt.nix
{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.lock";
  programs.nixfmt.enable = true;

}
