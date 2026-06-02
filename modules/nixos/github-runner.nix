{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.githubRunner;
in
{
  options.modules.nixos.githubRunner.enable =
    lib.mkEnableOption "self-hosted GitHub Actions runner for nix-config deploys";

  config = lib.mkIf cfg.enable {
    # The Actions runner bundles node20, which this nixpkgs flags insecure.
    nixpkgs.config.permittedInsecurePackages = [
      "nodejs-20.20.2"
      "nodejs-slim-20.20.2"
    ];

    # PAT (repo scope) used to auto-register the runner. Stored in sops.
    sops.secrets."gh-runner-token" = { };

    users.users.ghrunner = {
      isSystemUser = true;
      group = "ghrunner";
      home = "/var/lib/ghrunner";
      createHome = true;
      shell = pkgs.bashInteractive;
    };
    users.groups.ghrunner = { };

    services.github-runners.openclaw = {
      enable = true;
      url = "https://github.com/bpavlo/nix-config";
      tokenFile = config.sops.secrets."gh-runner-token".path;
      name = "openclaw";
      extraLabels = [ "openclaw" ];
      replace = true;
      user = "ghrunner";
      extraPackages = with pkgs; [
        git
        openssh
        nix
      ];
    };

    # Narrow: ghrunner may run only nixos-rebuild, passwordless.
    security.sudo.extraRules = [
      {
        users = [ "ghrunner" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
