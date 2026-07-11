{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.home.desktop;
in
{
  options.modules.home.desktop.enable =
    lib.mkEnableOption "desktop apps (browsers, social, GUI tools, gaming launchers)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bluetui
      gamescope
      gthumb
      heroic
      mpv-unwrapped
      obsidian
      papers
      qbittorrent
      quickshell
      signal-desktop
      slack
      telegram-desktop
      tor-browser
      vesktop
      wowup-cf
      zoom-us
    ];
  };
}
