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
      # Productivity GUI
      bitwarden-desktop
      obsidian
      qbittorrent

      # Wayland desktop
      quickshell
      bluetui

      # Social
      telegram-desktop
      signal-desktop
      vesktop
      slack
      zoom-us

      # GUI media
      gthumb
      papers
      mpv-unwrapped

      # Gaming
      gamescope
      heroic
      wowup-cf
    ];
  };
}
