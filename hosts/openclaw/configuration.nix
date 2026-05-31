{ lib, pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = false;
  };

  environment.systemPackages = [ pkgs.claude-code ];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp1s0.ipv6.addresses = [
    {
      address = "2a01:4f8:c015:2325::1";
      prefixLength = 64;
    }
  ];
  networking.defaultGateway6 = {
    address = "fe80::1";
    interface = "enp1s0";
  };
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
