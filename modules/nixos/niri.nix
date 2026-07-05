{
  config,
  lib,
  pkgs,
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

    services.greetd.settings.default_session.user = "greeter";

    programs.noctalia-greeter = {
      enable = true;
      settings = {
        session.default = "Niri";
        keyboard = {
          layout = "us,ca,ru,ua";
          options = "grp:win_space_toggle";
        };
        cursor = {
          theme = "Adwaita";
          size = 24;
        };
        appearance = {
          scheme = "Synced";
          hide_logo = true;
        };
      };
    };

    systemd.tmpfiles.settings."11-noctalia-greeter-appearance" = {
      "/var/lib/noctalia-greeter/appearance.json".C = {
        argument = "${pkgs.writeText "noctalia-greeter-appearance.json" (
          builtins.toJSON {
            version = 1;
            theme_mode = "dark";
            corner_radius_scale = 1.0;
            palette = {
              primary = "#aaaaaa";
              on_primary = "#111111";
              secondary = "#a7a7a7";
              on_secondary = "#111111";
              tertiary = "#cccccc";
              on_tertiary = "#111111";
              error = "#dddddd";
              on_error = "#111111";
              surface = "#111111";
              on_surface = "#828282";
              surface_variant = "#191919";
              on_surface_variant = "#5d5d5d";
              outline = "#3c3c3c";
              shadow = "#000000";
              hover = "#cccccc";
              on_hover = "#111111";
            };
          }
        )}";
        user = "root";
        group = "root";
        mode = "0644";
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
      pavucontrol
    ];

    programs.dconf.enable = true;

    systemd.user.services = {
      xdg-desktop-portal-gnome = {
        wantedBy = [ "graphical-session.target" ];
      };
      xdg-desktop-portal-gtk = {
        wantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
