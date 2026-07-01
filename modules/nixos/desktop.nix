{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.desktop;
  bluetoothCfg = cfg.bluetooth;
in
{
  options.modules.nixos.desktop.enable =
    lib.mkEnableOption "desktop services (audio, fonts, printing, bluetooth, fwupd, firefox)";

  options.modules.nixos.desktop.bluetooth = {
    playbackOnly = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Keep Bluetooth audio in A2DP-only playback mode.";
    };

    allowHeadsetProfile = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow HFP/HSP headset profiles for Bluetooth microphone use.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
          ];
        };

        "monitor.bluez.rules" = [
          {
            matches = [ { "device.name" = "~bluez_card.*"; } ];
            actions.update-props = {
              "bluez5.codecs" = [
                "sbc_xq"
                "sbc"
              ];
            };
          }
        ];
      };
    };

    # Firmware / power
    services.fwupd.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    # Apps & runtime
    services.flatpak.enable = true;
    programs.firefox.enable = true;

    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

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
