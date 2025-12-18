{ pkgs, ... }:

{
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    waybar
    mako
    swaylock
    swayidle
    xwayland-satellite
    wl-clipboard
  ];
}
