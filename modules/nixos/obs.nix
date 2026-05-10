{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.obs;
in
{
  options.modules.nixos.obs.enable = lib.mkEnableOption "OBS Studio with v4l2loopback virtual camera";
  config = lib.mkIf cfg.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera"
    '';

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}
