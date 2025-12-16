{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aws-vault
    awscli2
    google-cloud-sdk
    ssm-session-manager-plugin

    cargo
    elixir
    go
    jdk
    lua
    rustc
    unstable.nodejs_24
    poetry
    yarn

    gh
    hugo
    isort
    mermaid-cli
    pre-commit
    ruff
    stylua
    treefmt

    tenv
    terraform-docs
    terraformer
    tflint
    packer
    trivy

    colima
    docker
    k9s
    kubectl
    kubectx
    kubernetes-helm
    minikube

    bottom
    eza
    fastfetch
    gnupg
    lf
    mkpasswd
    nmap
    ripgrep
    tree
    yazi
    yt-dlp

    jellyfin-ffmpeg
    mpv-unwrapped

    nix-du
    nix-top
    nix-tree

    ollama

    teleport

    yamllint

    brave
    ghostty
  ];
}