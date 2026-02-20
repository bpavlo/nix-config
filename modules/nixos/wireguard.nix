{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Install WireGuard tools for manual management with wg-quick
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  # Required for WireGuard to work properly
  networking.firewall.checkReversePath = "loose";
}
