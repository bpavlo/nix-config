{ ... }:

# Legacy user config for pvl on jade (macOS)
# To be removed after macOS reinstall with pavlo user

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pvl = import ../modules/home/pvl.nix;
  };
}
