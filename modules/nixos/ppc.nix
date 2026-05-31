{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.nixos.ppc;
  pyEnv = pkgs.python3.withPackages (
    ps: with ps; [
      aiogram
      aiosqlite
      python-dotenv
    ]
  );
in
{
  options.modules.nixos.ppc.enable = lib.mkEnableOption "tg-newsletter Telegram bot";

  config = lib.mkIf cfg.enable {
    sops.secrets."ppc-env".restartUnits = [ "ppc.service" ];

    systemd.services.ppc = {
      description = "tg-newsletter Telegram bot";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      environment = {
        DB_PATH = "/var/lib/ppc/newsletter.db";
        SEND_RATE_PER_SEC = "20";
      };
      serviceConfig = {
        ExecStart = "${pyEnv}/bin/python ${inputs.ppc}/bot.py";
        WorkingDirectory = "${inputs.ppc}";
        DynamicUser = true;
        StateDirectory = "ppc";
        EnvironmentFile = config.sops.secrets."ppc-env".path;
        Restart = "on-failure";
        RestartSec = 5;
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
      };
    };
  };
}
