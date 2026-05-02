{ pkgs, inputs, ... }:

{
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

  # Fix greetd race condition with niri
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

  # Automounting for removable storage
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Enable XDG portal support for Chromium-based browsers
  environment.sessionVariables = {
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # Geolocation for Noctalia night light
  services.geoclue2.enable = true;

  # XDG portals for file pickers, screensharing, etc.
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

    # GNOME file manager for XDG portal file pickers
    nautilus

    # System utilities
    pwvucontrol
  ];

  programs.dconf.enable = true;

  # Ensure portal backends are started with the graphical session.
  # niri doesn't always auto-start D-Bus-activated portal backends reliably.
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
        "/run/current-system/sw"
        "/etc/profiles/per-user/pavlo"
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
}
