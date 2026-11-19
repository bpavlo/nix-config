{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.amd;
in
{

  options.modules.nixos.amd.enable = lib.mkEnableOption "amd GPU";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.amdgpu = {
      initrd.enable = true;
      overdrive.enable = true;
      opencl.enable = true;
    };

    services.lact = {
      enable = true;
      settings = {
        version = 7;
        daemon = {
          log_level = "info";
          admin_group = "wheel";
        };
        apply_settings_timer = 5;
      };
    };
  };
}
