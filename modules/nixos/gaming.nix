{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming.enable =
    lib.mkEnableOption "gaming (Steam, gamemode, mangohud, hardware video accel)";
  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;

    services.hardware.bolt.enable = true;

    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      vulkan-tools
      clinfo
    ];
  };
}
