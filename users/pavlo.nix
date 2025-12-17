{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pavlo = import ../modules/home;
  };
}
