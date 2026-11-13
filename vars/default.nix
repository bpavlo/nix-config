{
  username = "pavlo";
  fullName = "Pavlo";
  timeZone = "America/Toronto";
  locale = "en_CA.UTF-8";
  email = "git@bpavlo.com";

  hosts = {
    cougar = {
      system = "x86_64-linux";
      role = "workstation";
      signingPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYnBRG3jHvnjCUXZMTITQDqYWgeCD1KyJVUOvfgkDeI pavlo@cougar";
    };
    ghost = {
      system = "x86_64-linux";
      role = "workstation";
      username = "gremlin";
      signingPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLACEHOLDERPLACEHOLDERPLACEHOLDERPLACEHOLDERx gremlin@ghost";
    };
  };
}
