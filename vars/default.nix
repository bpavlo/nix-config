{
  username = "pavlo";
  fullName = "Pavlo";
  timeZone = "America/Toronto";
  locale = "en_CA.UTF-8";
  email = "git@bpavlo.com";

  authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI9rFbUbPVTa1FH/NCTm1Oyszd9FZdxiw9JrhlCcKwY pavlo@phoenix"
  ];

  hosts = {
    phoenix = {
      system = "x86_64-linux";
      role = "workstation";
      signingPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI9rFbUbPVTa1FH/NCTm1Oyszd9FZdxiw9JrhlCcKwY pavlo@phoenix";
    };
    cougar = {
      system = "x86_64-linux";
      role = "workstation";
      signingPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYnBRG3jHvnjCUXZMTITQDqYWgeCD1KyJVUOvfgkDeI pavlo@cougar";
    };
    openclaw = {
      system = "x86_64-linux";
      role = "server";
    };
  };
}
