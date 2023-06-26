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
    darwinConfigurations = (
      import ./darwin {
        inherit darwin home-manager nixpkgs;
        system = "aarch64-darwin";
        user   = "pbunakalia";
        }
      );
    }; 
}
