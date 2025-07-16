{ pkgs, ... }:

{
  programs = {
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

        # Go binaries
        export PATH="$HOME/go/bin:$PATH"
      '';
    };

    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
