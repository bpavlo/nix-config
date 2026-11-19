{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.nvidia;
in
{

  options.modules.nixos.nvidia.enable = lib.mkEnableOption "NVIDIA GPU";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
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
        gpus."10DE:1EC7-10DE:13AA-0000:07:00.0" = {
          power_mizer_mode = "Adaptive";
          power_cap = 260.0;
          gpu_clock_offsets."0" = 130;
          mem_clock_offsets."0" = 1800;
          min_core_clock = 300;
          max_core_clock = 2010;
        };
      };
    };
  };
}
