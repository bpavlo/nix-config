{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Key repeat speed (matches macOS: InitialKeyRepeat=14, KeyRepeat=1)
  services.xserver.autoRepeatDelay = 210; # ms before repeat starts
  services.xserver.autoRepeatInterval = 15; # ms between repeats

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    geary
  ];
}
