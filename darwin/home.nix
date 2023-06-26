{ pkgs, ... }: 

{
  manual.manpages.enable = false;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      awscli
      bottom
      cargo
      colima
      exa
      gnupg
      karabiner-elements
      keepassxc
      kubernetes-helm
      k9s
      kubectx
      kubectl
      lf
      lua
      macchina
      mpc-cli
      mpd
      mpv-unwrapped
      nb
      ncmpcpp
      neovim
      nodejs_20
      packer
      ripgrep
      rustc
      starship
      stylua
      syncthing
      terraform
      wezterm
      wireguard-go
      wireguard-tools
      utm
      yt-dlp
      zathura
    ];
  };

  programs = {
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
    neovim = {
      defaultEditor = true;
    };
  };
}
