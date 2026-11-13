{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.secureboot;
in
{
  options.modules.nixos.secureboot.enable =
    lib.mkEnableOption "lanzaboote Secure Boot with TPM2 unlock of cryptroot";

  config = lib.mkMerge [
    { boot.loader.systemd-boot.enable = !cfg.enable; }
    (lib.mkIf cfg.enable {
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      security.tpm2 = {
        enable = true;
        pkcs11.enable = true;
        tctiEnvironment.enable = true;
      };

      boot.initrd.luks.devices."cryptroot".crypttabExtraOpts = [ "tpm2-device=auto" ];
    })
  ];
}
