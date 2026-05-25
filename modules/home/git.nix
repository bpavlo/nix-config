{
  config,
  osConfig,
  vars,
  ...
}:
let
  host = osConfig.networking.hostName;
  signingKeyPath = "${config.home.homeDirectory}/.ssh/id_ed25519_${host}.pub";
  signingPubkey = vars.hosts.${host}.signingPubkey;
in
{
  programs.git = {
    enable = true;
    settings = {
      user.name = vars.fullName;
      user.email = vars.email;
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
    };
    signing = {
      key = signingKeyPath;
      signByDefault = true;
      format = "ssh";
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${vars.email} ${signingPubkey}
  '';
}
