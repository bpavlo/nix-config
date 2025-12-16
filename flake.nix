{
  description = "NixOS and nix-darwin configurations";

  inputs = {
    # nixos-unstable is tested against NixOS, more stable than nixpkgs-unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Keep stable as fallback if needed
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      darwin,
      nixos-hardware,
      treefmt-nix,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      treefmtEval = forAllSystems (
        system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );

      overlays = [
        (final: prev: {
          # Stable packages available as pkgs.stable.xxx if needed
          stable = import nixpkgs-stable {
            system = final.system;
            config.allowUnfree = true;
          };
        })
      ];

      nixpkgsConfig = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      darwinConfigurations.jade = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/jade
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nixpkgs.config = nixpkgsConfig;
          }
        ];
      };

      nixosConfigurations.phoenix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.framework-13-7040-amd
          ./hosts/nixos/phoenix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nixpkgs.config = nixpkgsConfig;
          }
        ];
      };
    };
}
