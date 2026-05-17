{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.desktop;
in
{
  options.modules.nixos.desktop.enable =
    lib.mkEnableOption "desktop services (audio, fonts, printing, bluetooth, fwupd, firefox)";

  config = lib.mkIf cfg.enable {
    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Firmware / power
    services.fwupd.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    # Apps & runtime
    services.flatpak.enable = true;
    programs.firefox.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Printing
    services.printing = {
      enable = true;
      drivers = [
        pkgs.epson-escpr
        pkgs.epson-escpr2
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Fonts
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

      fontconfig.defaultFonts = {
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
