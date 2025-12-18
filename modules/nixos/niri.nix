{ pkgs, inputs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    qt6.qtwayland
    swaybg
    fuzzel
  ];

  programs.dconf.enable = true;
}
