{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    # Add keys to agent automatically
    addKeysToAgent = "yes";
  };

  # Configure Bitwarden SSH agent on Linux
  home.sessionVariables = lib.mkIf pkgs.stdenv.isLinux {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.config/Bitwarden/ssh-agent.sock";
  };

  # Disable other SSH agents to avoid conflicts
  services.ssh-agent.enable = false;
}
