{ nixpkgs-stable, ghostty }:

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

  # ghostty 1.4.0 (NixOS/nixpkgs#579717) is on master but nixos-unstable
  # hasn't advanced yet. Drop once the channel has it.
  (final: _prev: {
    ghostty = ghostty.packages.${final.stdenv.hostPlatform.system}.default;
  })
]
