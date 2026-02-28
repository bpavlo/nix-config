{ pkgs, lib, ... }:

{
  gtk = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    font = {
      name = "Inter";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings = lib.mkIf pkgs.stdenv.isLinux {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Override Telegram's desktop entry to use the XDG portal file picker
  # instead of the GTK2 platform theme which gives the old-style Qt dialog.
  xdg.desktopEntries = lib.mkIf pkgs.stdenv.isLinux {
    "org.telegram.desktop" = {
      name = "Telegram";
      exec = "env QT_QPA_PLATFORMTHEME=xdgdesktopportal Telegram -- %U";
      icon = "org.telegram.desktop";
      terminal = false;
      categories = [ "Chat" "Network" "InstantMessaging" "Qt" ];
      mimeType = [ "x-scheme-handler/tg" "x-scheme-handler/tonsite" ];
      settings = {
        StartupWMClass = "TelegramDesktop";
        DBusActivatable = "true";
        SingleMainWindow = "true";
        X-GNOME-UsesNotifications = "true";
      };
    };
  };
}
