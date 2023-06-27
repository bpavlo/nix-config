{
  description = "flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { nixpkgs, home-manager, darwin, ... }: 

  {
    darwinConfigurations.darwin = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin-conf.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.pbunakalia = import ./darwin-home.nix;
        }
      ];  
    };
  };
}
