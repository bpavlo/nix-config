{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [

    # Must Have
    brave
    bitwarden-desktop
    bitwarden-cli

    # desktop
    quickshell
    bluetui

    # Social
    telegram-desktop
    signal-desktop
    vesktop
    slack
    zoom-us

    # AI
    gemini-cli
    codex
    claude-code
    ollama

    # Cloud & Infrastructure
    aws-vault
    awscli2
    google-cloud-sdk
    ssm-session-manager-plugin
    teleport

    # Containers & Kubernetes
    docker
    k9s
    kubectl
    kubectx
    kubernetes-helm
    minikube
    trivy

    # IaC
    packer
    tenv
    terraform-docs
    terraformer
    tflint

    # Languages & Runtimes
    cargo
    elixir
    go
    jdk
    lua
    nodejs_24
    poetry
    rustc
    yarn

    # Dev Tools
    gh
    hugo
    isort
    mermaid-cli
    pre-commit
    ruff
    stylua
    treefmt

    # CLI Utilities
    bottom
    eza
    fastfetch
    gnupg
    mkpasswd
    nmap
    ripgrep
    tree
    yamllint
    yazi
    yt-dlp

    # Media
    jellyfin-ffmpeg
    mpv-unwrapped

    # Gaming
    gamescope

    # Nix Tools
    nix-du
    nix-top
    nix-tree

    # LSPs
    bash-language-server
    gopls
    lua-language-server
    nil
    pyright
    terraform-ls

  ];
}
