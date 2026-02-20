{
  description = "NixOS and nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      disko,
      lanzaboote,
      llm-agents,
      niri,
      noctalia,
      zen-browser,
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
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          niri.nixosModules.niri
          ./hosts/phoenix
          ./hosts/phoenix/disko-config.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nixpkgs.config = nixpkgsConfig;
          }
        ];
      };
    };
}
