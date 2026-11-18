{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.benchmark;
in
{
  options.modules.nixos.benchmark.enable =
    lib.mkEnableOption "hardware diagnostics, benchmarking and stress-testing tools";

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.memtest86.enable = true;

    hardware.cpu.amd.ryzen-smu.enable = true;

    environment.systemPackages = with pkgs; [
      dmidecode
      lshw
      pciutils
      usbutils
      hwinfo
      inxi
      lm_sensors

      stress-ng
      stressapptest
      memtester
      sysbench
      tinymembench

      lm_sensors
      s-tui

      smartmontools
      nvme-cli
      fio

      vulkan-tools
    ];
  };
}
