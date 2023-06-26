{ darwin, home-manager, nixpkgs, system, user, ...}:

{
  darwin = darwin.lib.darwinSystem rec {
    inherit system;

    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };
}
