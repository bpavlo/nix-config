{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };

  home.sessionVariables = lib.mkIf pkgs.stdenv.isLinux {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
  };

  services.ssh-agent.enable = false;
}
