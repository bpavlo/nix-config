{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "amdgpu.dcdebugmask=0x12"
      "amdgpu.ppfeaturemask=0xffffffff"
      "iomem=relaxed"
      "quiet"
      "loglevel=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    ryzenadj
    wireguard-tools
  ];
}
