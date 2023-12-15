{ config, pkgs, ... }:

{
  imports = (import ./config);
  manual.manpages.enable = false;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      awscli
      alacritty
      bottom
      cargo
      colima
      exa
      gnupg
      go
      hugo
      k9s
      karabiner-elements
      keepassxc
      kubernetes-helm
      kubectx
      kubectl
      lf
      lua
      macchina
      marksman
      mpc-cli
      mpd
      mpv-unwrapped
      nb
      ncmpcpp
      nmap
      nodejs_20
      packer
      ripgrep
      rustc
      spotify
      starship
      stylua
      syncthing
      terraform
      tflint
      tree-sitter
      w3m-nox
      wezterm
      wireguard-go
      wireguard-tools
      utm
      yarn
      yt-dlp
      zathura
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };
      shellAliases = {
        ls = "exa --icons --color=auto --git-ignore --git -F --extended";
        grep = "ripgrep";
        diff = "diff --color=auto";
        cp = "cp -iv";
        ka = "killall";
        g = "git";
        sdn = "shutdown -h now";
        v = "nvim";
        z = "zathura";
        ncmp = "ncmpcpp";
      };
      initExtra = ''
        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # End Nix
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        '';
    };
    starship = {
      enable = true;
      settings = {
        format = builtins.concatStringsSep "" [
        "$directory"
        "$git_branch"
        "$character"
        ];
        };
    };
  };
}
