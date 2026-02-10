{ pkgs, lib, ... }:

{
  gtk = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

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
  };

  dconf.settings = lib.mkIf pkgs.stdenv.isLinux {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
