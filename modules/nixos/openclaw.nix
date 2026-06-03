{
  config,
  lib,
  pkgs,
  inputs,
  vars,
  ...
}:
let
  cfg = config.modules.nixos.openclaw;
  gwToken = config.sops.secrets."openclaw-gateway-token".path;
  tgToken = config.sops.secrets."openclaw-telegram-token".path;
  caldavPw = config.sops.secrets."openclaw-caldav-password".path;
  gitSshKey = config.sops.secrets."openclaw-ssh-key".path;
  bbToken = config.sops.secrets."openclaw-bitbucket-token".path;
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
    sops.secrets."openclaw-caldav-password".owner = "openclaw";
    sops.secrets."openclaw-ssh-key".owner = "openclaw";
    sops.secrets."openclaw-bitbucket-token".owner = "openclaw";

    home-manager.users.openclaw =
      { ... }:
      {
        imports = [ inputs.nix-openclaw.homeManagerModules.openclaw ];
        home.stateVersion = "25.11";
        home.enableNixpkgsReleaseCheck = false;
        home.packages = with pkgs; [
          # CLI utilities
          bat
          bottom
          eza
          fd
          jq
          ripgrep
          tree
          yamllint

          # Archives
          p7zip
          unar

          # Git / forge
          gh
          glab
          pre-commit
          treefmt

          # Python
          python312
          uv
          ruff
          isort

          # Secrets
          sops
          ssh-to-age
        ];

        programs.bash = {
          enable = true;
          initExtra = ''export OPENCLAW_GATEWAY_TOKEN="$(cat ${gwToken} 2>/dev/null)"'';
        };

        programs.git = {
          enable = true;
          settings.user = {
            name = vars.fullName;
            email = vars.email;
          };
          signing = {
            format = "ssh";
            key = gitSshKey;
            signByDefault = true;
          };
        };

        home.file.".ssh/config".text = ''
          Host github.com bitbucket.org
            IdentityFile ${gitSshKey}
            IdentitiesOnly yes
            StrictHostKeyChecking accept-new
        '';

        programs.openclaw = {
          enable = true;
          documents = inputs.openclaw-persona;

          customPlugins = [
            { source = inputs.agent-skills.outPath; }
          ];

          environment = {
            OPENCLAW_GATEWAY_TOKEN = gwToken;
            CALDAV_PASSWORD = caldavPw;
            BB_USER = "pbunakalia@provectus.com";
            BB_TOKEN = bbToken;
          };

          config = {
            gateway = {
              mode = "local";
              bind = "loopback";
              auth.mode = "token";
              tailscale.mode = "serve";
            };

            commands.ownerAllowFrom = [ "telegram:272820312" ];
            channels.telegram = {
              tokenFile = tgToken;
              allowFrom = [ 272820312 ];
              dmPolicy = "pairing";
              groupPolicy = "allowlist";
              groupAllowFrom = [ 272820312 ];
              groups."-1003931602419" = {
                enabled = true;
                requireMention = false;
              };
            };

            agents.defaults = {
              model.primary = "anthropic/claude-opus-4-8";
              models = {
                "openai/gpt-5.5".agentRuntime.id = "openclaw";
                "anthropic/claude-opus-4-8".agentRuntime.id = "claude-cli";
              };
            };
            tools.exec.mode = "auto";

            mcp.servers.atlassian = {
              command = "npx";
              args = [
                "-y"
                "mcp-remote"
                "https://mcp.atlassian.com/v1/sse"
                "5598"
              ];
            };
          };
        };
      };
  };
}
