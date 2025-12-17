{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      # AI
      claude-code
      gemini-cli
      codex
      ollama

      # Cloud & Infrastructure
      aws-vault
      awscli2
      google-cloud-sdk
      ssm-session-manager-plugin
      teleport

      # Containers & Kubernetes
      colima
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
      bob

      # CLI Utilities
      bottom
      eza
      fastfetch
      gnupg
      lf
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

      # Must Have
      brave
      ghostty
    ];
}
