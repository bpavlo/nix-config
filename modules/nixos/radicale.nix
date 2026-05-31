{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.radicale;
in
{
  options.modules.nixos.radicale.enable = lib.mkEnableOption "Radicale CalDAV/CardDAV server";

  config = lib.mkIf cfg.enable {
    sops.secrets."radicale-htpasswd" = {
      owner = "radicale";
      restartUnits = [ "radicale.service" ];
    };

    services.radicale = {
      enable = true;
      settings = {
        server.hosts = [ "0.0.0.0:5232" ];
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.sops.secrets."radicale-htpasswd".path;
          htpasswd_encryption = "bcrypt";
        };
        storage.filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };
}
