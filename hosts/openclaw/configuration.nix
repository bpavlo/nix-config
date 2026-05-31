{ lib, ... }:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = false;
  };

  networking.useDHCP = lib.mkDefault true;
  zramSwap.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  sops.age.sshKeyPaths = lib.mkForce [ "/etc/ssh/ssh_host_ed25519_key" ];
}
