{ ... }:

{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    casks = [
      "appcleaner"
      "battery"
      "bitwarden"
      "brave-browser"
      "caffeine"
      "discord"
      "firefox"
      "ghostty"
      "heroic"
      "iina"
      "nikitabobko/tap/aerospace"
      "obs"
      "obsidian"
      "qbittorrent"
      "raycast"
      "slack"
      "steam"
      "telegram-desktop"
      "tunnelblick"
      "whisky"
    ];
  };
}
