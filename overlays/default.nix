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

  # Vial's bundled libqxcb.so links libgpg-error.so.0, which the AppImage
  # FHS env doesn't provide, so Qt fails to load the xcb platform plugin.
  (_final: prev: {
    vial = prev.vial.override {
      appimageTools = prev.appimageTools // {
        wrapType2 =
          args: prev.appimageTools.wrapType2 (args // { extraPkgs = pkgs: [ pkgs.libgpg-error ]; });
      };
    };
  })

  # ghostty 1.4.0 (NixOS/nixpkgs#579717) is on master but nixos-unstable
  # hasn't advanced yet. Drop once the channel has it.
  (final: _prev: {
    ghostty = ghostty.packages.${final.stdenv.hostPlatform.system}.default;
  })
]
