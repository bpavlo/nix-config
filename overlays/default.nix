{ nixpkgs-stable }:

[
  (final: _prev: {
    stable = import nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };

    brave-origin = final.callPackage ../pkgs/brave-origin/package.nix { };
  })
]
