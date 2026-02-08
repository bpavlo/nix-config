{ pkgs, lib, ... }:

{
  home.packages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-vaapi
        wlrobs
        droidcam-obs
      ];
    })
  ];
}
