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
      eza
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
      marksman
      mpc-cli
      mpd
      mpv-unwrapped
      ncmpcpp
      nmap
      nodejs_20
      packer
      qbittorrent
      ripgrep
      rustc
      spotify
      starship
      stylua
      syncthing
      terraform
      teleport
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
      syntaxHighlighting = {
	enable = true;
};
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };
      shellAliases = {
        ls = "exa --color=auto --git-ignore --git -F --extended";
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
    alacritty = {
      enable = true;
      settings = {  
        window.padding = {
          x = 10;
          y = 10;
        };
        colors = {
          primary = {
            background = "#002b36";
            foreground = "#839496";
          };
          normal = {
            black   = "#073642";
            red     = "#dc322f";
            green   = "#859900";
            yellow  = "#b58900";
            blue    = "#268bd2";
            magenta = "#d33682";
            cyan    = "#2aa198";
            white   = "#eee8d5";
          };
          bright = {
            black   = "#002b36";
            red     = "#cb4b16";
            green   = "#586e75";
            yellow  = "#657b83";
            blue    = "#839496";
            magenta = "#6c71c4";
            cyan    = "#93a1a1";
            white   = "#fdf6e3";
        };
        };
      };
    };
  };
}
