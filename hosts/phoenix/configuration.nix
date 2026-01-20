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

  services.flatpak.enable = true;

  services.tailscale.enable = true;

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

  hardware.bluetooth.enable = true;
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
  ];

  fonts = {
    packages = with pkgs; [
      # Nerd fonts for terminal
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.commit-mono

      # UI fonts
      inter
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
