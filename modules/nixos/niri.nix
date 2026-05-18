{
  config,
  lib,
  pkgs,
  inputs,
  vars,
  ...
}:
let
  cfg = config.modules.nixos.niri;
in
{
  options.modules.nixos.niri.enable =
    lib.mkEnableOption "niri compositor with greetd, portals, and noctalia";
  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd niri-session";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    programs.seahorse.enable = true;

    services.udisks2.enable = true;
    services.gvfs.enable = true;

    services.tumbler.enable = true;
    services.gnome.sushi.enable = true;

    environment.sessionVariables = {
      NIXOS_XDG_OPEN_USE_PORTAL = "1";
    };

    services.geoclue2.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gnome"
            "gtk"
          ];
        };
        niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      qt5.qtwayland
      qt6.qtwayland
      adwaita-qt6
      swaybg
      brightnessctl
      playerctl
      swaylock
      grim
      slurp
      satty

      nautilus
      file-roller
      gnome-text-editor

      pwvucontrol
    ];

    programs.dconf.enable = true;

    systemd.user.services = {
      xdg-desktop-portal-gnome = {
        wantedBy = [ "graphical-session.target" ];
      };
      xdg-desktop-portal-gtk = {
        wantedBy = [ "graphical-session.target" ];
      };
      noctalia-shell = {
        description = "Noctalia shell";
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        path = [
          "/run/wrappers"
          "/run/current-system/sw"
          "/etc/profiles/per-user/${vars.username}"
        ];
        serviceConfig = {
          ExecStart = "${
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          }/bin/noctalia-shell";
          Restart = "on-failure";
          RestartSec = "3s";
        };
      };
    };
  };
}
