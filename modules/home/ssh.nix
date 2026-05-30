{ osConfig, config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*".addKeysToAgent = "yes";

      "github.com" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_${osConfig.networking.hostName}";
      };
    };
  };

  services.ssh-agent.enable = false;
}
