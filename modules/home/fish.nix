{ pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
        fish_vi_key_bindings
        set -gx GPG_TTY (tty)
      '';

      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
      ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
