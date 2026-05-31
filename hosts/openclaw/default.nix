{ vars, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix
    ../../modules/nixos/ppc.nix
    ../../modules/nixos/openclaw.nix
    ../../modules/nixos/radicale.nix
    ../../modules/nixos/syncthing.nix
  ];

  modules.nixos.ppc.enable = false;
  modules.nixos.openclaw.enable = true;
  modules.nixos.radicale.enable = true;
  modules.nixos.syncthing.enable = true;

  users.users.pavlo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = vars.authorizedKeys;
  };
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = "hm-backup";
  };

  system.stateVersion = "25.11";
}
