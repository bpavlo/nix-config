{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "amdgpu.dcdebugmask=0x12"
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.printing = {
    enable = true;
    drivers = [
      pkgs.epson-escpr
      pkgs.epson-escpr2
    ];
  };

  # Network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.fwupd.enable = true;

  services.flatpak.enable = true;

  services.tailscale.enable = true;

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      log-driver = "journald";
    };
  };

  # Key remapping - remap Caps Lock to Alt
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "leftalt";
      };
    };
  };

  hardware.bluetooth.enable = false;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  networking.networkmanager.wifi = {
    powersave = false;
    scanRandMacAddress = false;
  };

  services.udev.extraRules = ''
    # Keychron devices - allow user access for WebHID
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
  '';

  programs.fish.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wdisplays
    wlr-randr
    system-config-printer
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.commit-mono
      nerd-fonts.roboto-mono

      inter
      roboto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [
          "FiraCode Nerd Font"
          "Noto Sans Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
