{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
        export GPG_TTY=$(tty)
        export PATH="$HOME/Library/Python/3.9/bin:$PATH"
        export PATH="$HOME/.npm/bin:$PATH"
        export PATH="$HOME/go/bin:$PATH"
        export PATH="$HOME/.cargo/bin:$PATH"
      '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}