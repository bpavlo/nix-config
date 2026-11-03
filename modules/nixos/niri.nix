{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.niri;
  monochrome = import ../../lib/palettes/monochrome.nix;

  # Convert a noctalia palette variant (mPrimary, mOnSurfaceVariant, ..., terminal) to the
  # greeter's [appearance.palette] keys (primary, on_surface_variant, ...). The greeter
  # needs all 16 color roles for the palette to be complete; terminal colors don't apply.
  toGreeterPalette = variant: {
    primary = variant.mPrimary;
    on_primary = variant.mOnPrimary;
    secondary = variant.mSecondary;
    on_secondary = variant.mOnSecondary;
    tertiary = variant.mTertiary;
    on_tertiary = variant.mOnTertiary;
    error = variant.mError;
    on_error = variant.mOnError;
    surface = variant.mSurface;
    on_surface = variant.mOnSurface;
    surface_variant = variant.mSurfaceVariant;
    on_surface_variant = variant.mOnSurfaceVariant;
    outline = variant.mOutline;
    shadow = variant.mShadow;
    hover = variant.mHover;
    on_hover = variant.mOnHover;
  };
in
{
  options.modules.nixos.niri.enable =
    lib.mkEnableOption "niri compositor with greetd, portals, and noctalia";
  config = lib.mkIf cfg.enable {
    niri-flake.cache.enable = false;

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd.settings.default_session.user = "greeter";

    services.displayManager.noctalia-greeter = {
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
          theme_mode = "dark";
          # A complete palette here wins over anything Sync writes to sync.toml.
          palette = toGreeterPalette monochrome.dark;
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

    programs.ssh.enableAskPassword = true;

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
