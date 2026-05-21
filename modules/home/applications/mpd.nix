{
  config,
  lib,
  ...
}:

{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";

    network.startWhenNeeded = true;

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };

  services.mpd-mpris = {
    enable = true;
  };

  systemd.user.services.mpd = {
    Unit.Wants = [ "mpd-mpris.service" ];
  };

  systemd.user.services.mpd-mpris = {
    Install.WantedBy = lib.mkForce [ ];
  };
}
