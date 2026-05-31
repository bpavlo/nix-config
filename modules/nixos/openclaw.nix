{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.nixos.openclaw;
  gwToken = config.sops.secrets."openclaw-gateway-token".path;
  apiKey = config.sops.secrets."openclaw-anthropic-api-key".path;
  tgToken = config.sops.secrets."openclaw-telegram-token".path;
in
{
  options.modules.nixos.openclaw.enable =
    lib.mkEnableOption "openclaw gateway via nix-openclaw under a dedicated user";

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.nix-openclaw.overlays.default ];

    users.users.openclaw = {
      isNormalUser = true;
      home = "/home/openclaw";
      linger = true;
    };

    sops.secrets."openclaw-gateway-token".owner = "openclaw";
    sops.secrets."openclaw-anthropic-api-key".owner = "openclaw";
    sops.secrets."openclaw-telegram-token".owner = "openclaw";

    home-manager.users.openclaw =
      { ... }:
      {
        imports = [ inputs.nix-openclaw.homeManagerModules.openclaw ];
        home.stateVersion = "25.11";

        programs.openclaw = {
          enable = true;

          environment = {
            OPENCLAW_GATEWAY_TOKEN = gwToken;
            ANTHROPIC_API_KEY = apiKey;
          };

          config = {
            gateway = {
              mode = "local";
              bind = "loopback";
              auth.mode = "token";
              tailscale.mode = "serve";
            };
            channels.telegram = {
              tokenFile = tgToken;
              allowFrom = [ 272820312 ];
              dmPolicy = "pairing";
            };
            agents.defaults.model.primary = "anthropic/claude-opus-4-8";
            tools.exec = {
              security = "deny";
              ask = "always";
            };
          };
        };
      };
  };
}
