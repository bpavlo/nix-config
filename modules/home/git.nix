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
    userName = vars.fullName;
    userEmail = vars.email;
    signing = {
      key = signingKeyPath;
      signByDefault = true;
      format = "ssh";
    };
    extraConfig = {
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${vars.email} ${signingPubkey}
  '';
}
