{ ... }:

{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;

    taps = [
      "nikitabobko/tap"
    ];

    brews = [
      "syncthing"

      "awscli"
      "gh"
      "go"
      "hugo"
      "lua"
      "node"
      "poetry"
      "pre-commit"
      "ruff"
      "rustup"
      "stylua"
      "terraform-docs"
      "tflint"
      "treefmt"
      "yamllint"
      "yarn"

      "colima"
      "docker"
      "k9s"
      "kubectl"
      "kubectx"
      "helm"
      "minikube"
      "trivy"

      "fastfetch"
      "gnupg"
      "nmap"
      "yazi"
      "yt-dlp"
      "zoxide"
      "pyenv"

      "bash-language-server"
      "gopls"
      "lua-language-server"
      "nil"
      "pyright"
      "terraform-ls"
    ];

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

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = false;
    };
  };
}
