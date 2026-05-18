{
  config,
  inputs,
  vars,
  ...
}:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/${config.networking.hostName}/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.sshKeyPaths = [
      "/home/${vars.username}/.ssh/id_ed25519_${config.networking.hostName}"
    ];
  };
}
