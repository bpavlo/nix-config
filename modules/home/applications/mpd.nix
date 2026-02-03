{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.mpd = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };

  services.mpd-mpris = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
  };
}
