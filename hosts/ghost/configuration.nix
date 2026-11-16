{ pkgs, lib, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];

    consoleLogLevel = 0;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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

  programs.gamemode.settings.cpu.pin_cores = lib.mkForce "no";

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      log-driver = "journald";
    };
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "esc";
      };
    };
  };

  networking.networkmanager.wifi = {
    powersave = false;
    scanRandMacAddress = false;
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", \
      MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    startupProfile = "off";
  };

  environment.systemPackages = with pkgs; [
    wdisplays
    wlr-randr
    system-config-printer
    wireguard-tools
    nvtopPackages.nvidia
    sbctl
  ];
}
