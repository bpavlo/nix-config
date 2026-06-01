{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.syncthing;
in
{
  options.modules.nixos.syncthing.enable = lib.mkEnableOption "Syncthing for the Obsidian vault";

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      overrideDevices = false;
      overrideFolders = false;
      settings.folders.brain.path = "/var/lib/syncthing/brain";
    };

    systemd.services.syncthing.serviceConfig.UMask = "0007";
  };
}
