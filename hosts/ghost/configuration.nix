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

  environment.systemPackages = with pkgs; [
    wdisplays
    wlr-randr
    system-config-printer
    wireguard-tools
    nvtopPackages.nvidia
    sbctl
  ];
}
