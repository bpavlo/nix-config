{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "amdgpu.dcdebugmask=0x12"
    ];
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.fwupd.enable = true;

  services.tailscale.enable = true;

  # WiFi optimizations
  networking.networkmanager.wifi = {
    powersave = false; # Better performance
    scanRandMacAddress = false; # More reliable connections
  };

  # Prefer 5GHz WiFi when available
  networking.networkmanager.connectionConfig."wifi.band" = "5ghz";

  # Enable WebHID for Keychron configurator (launcher.keychron.com)
  services.udev.extraRules = ''
    # Keychron devices - allow user access for WebHID
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
  '';

  programs.fish.enable = true;

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.commit-mono
  ];
}
