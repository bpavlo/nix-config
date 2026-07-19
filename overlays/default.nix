{ nixpkgs-stable }:

[
  (final: _prev: {
    stable = import nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  })

  (final: _prev: {
    usbeehive = final.callPackage ../pkgs/usbeehive { };
  })
]
