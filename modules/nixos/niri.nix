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

  # Geolocation for gammastep
  services.geoclue2.enable = true;

  # XDG portals for file pickers, screensharing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "gnome";
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    qt6.qtwayland
    swaybg
    fuzzel
    brightnessctl
    playerctl

    # File manager
    nautilus

    # Modular shell components
    waybar
    mako
    swayosd
    gammastep
    pwvucontrol
  ];

  programs.dconf.enable = true;
}
