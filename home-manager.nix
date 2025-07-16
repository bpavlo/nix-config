{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./zellij.nix
    ./zathura.nix
    ./starship.nix
    ./aerospace.nix
  ];
  manual.manpages.enable = false;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      trivy 
      nodejs_24
      treefmt
      aws-vault
      terraformer
      yazi
      google-cloud-sdk
      gh
      tree
      jellyfin-ffmpeg
      # osx specific
      colima
      utm
      # general
      aws-vault
      awscli2
      alacritty
      bottom
      cargo
      docker
      eza
      fastfetch
      gnupg
      go
      hugo
      k9s
      kubernetes-helm
      kubectx
      kubectl
      lf
      lua
      minikube
      mpv-unwrapped
      mkpasswd
      nmap
      ollama
      openvpn
      packer
      pre-commit
      qbittorrent
      ripgrep
      rustc
      stylua
      teleport
      tenv
      terraform-docs
      tflint
      yarn
      yt-dlp
      elixir
      jdk
      yamllint
      ruff
      poetry
      isort
    ];
  };

  programs = {
    ghostty = {
      enable = false;
      enableZshIntegration = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox = {
      enable = false;
      package = pkgs.firefox-unwrapped;
    };
    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    home-manager = {
      enable = true;
    };
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };

      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };
      shellAliases = {
        ls = "eza --color=auto --git -F --extended";
        diff = "diff --color=auto";
        cp = "cp -iv";
        ka = "killall";
        g = "git";
        sdn = "shutdown -h now";
        v = "nvim";
      };
      initContent = ''
        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # End Nix
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        export GPG_TTY=$(tty)

        # Python fix
        export PATH="$HOME/Library/Python/3.9/bin:$PATH"
        export PATH="$HOME/.npm/bin:$PATH"
      '';
    };
  };
}
