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
      extraGroups = [ "syncthing" ];
    };

    sops.secrets."openclaw-gateway-token".owner = "openclaw";
    sops.secrets."openclaw-telegram-token".owner = "openclaw";

    home-manager.users.openclaw =
      { ... }:
      {
        imports = [ inputs.nix-openclaw.homeManagerModules.openclaw ];
        home.stateVersion = "25.11";
        home.enableNixpkgsReleaseCheck = false;

        programs.bash = {
          enable = true;
          initExtra = ''export OPENCLAW_GATEWAY_TOKEN="$(cat ${gwToken} 2>/dev/null)"'';
        };

        programs.openclaw = {
          enable = true;
          documents = inputs.openclaw-persona;

          environment = {
            OPENCLAW_GATEWAY_TOKEN = gwToken;
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
            agents.defaults = {
              model.primary = "openai/gpt-5.5";
              models."openai/gpt-5.5".agentRuntime.id = "openclaw";
            };
            tools.exec = {
              security = "full";
              ask = "off";
            };
          };
        };
      };
  };
}
