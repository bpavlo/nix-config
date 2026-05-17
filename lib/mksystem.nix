{
  nixpkgs,
  inputs,
  vars,
}:

name:
{
  headless ? false,
}:

let
  hostMeta = vars.hosts.${name};
in
nixpkgs.lib.nixosSystem {
  system = hostMeta.system;
  specialArgs = { inherit inputs vars headless; };
  modules = [
    inputs.disko.nixosModules.disko
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.niri.nixosModules.niri
    inputs.home-manager.nixosModules.home-manager
    ../modules/common
    ../hosts/${name}

    (
      { ... }:
      {
        networking.hostName = name;
        nixpkgs.overlays = import ../overlays { inherit (inputs) nixpkgs-stable; };
        nixpkgs.config.allowUnfree = true;
      }
    )
  ];
}
