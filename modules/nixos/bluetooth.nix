{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.bluetooth;

  outboundRoles = [ "a2dp_source" ] ++ lib.optional cfg.allowHeadsetProfile "hfp_ag";
  inboundRoles = [ "a2dp_sink" ] ++ lib.optional cfg.allowHeadsetProfile "hfp_hf";
  roles = outboundRoles ++ lib.optionals (!cfg.playbackOnly) inboundRoles;
in
{
  options.modules.nixos.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth stack with PipeWire A2DP audio";

    playbackOnly = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Restrict Bluetooth audio to playback from this machine out to speakers
        and headphones. When false the machine additionally advertises itself as
        a Bluetooth speaker that remote devices can stream into.
      '';
    };

    allowHeadsetProfile = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Offer HFP so the microphone on a Bluetooth headset is usable. Playback
        drops to call-grade audio whenever the headset profile is active.
      '';
    };

    autoSwitchToHeadset = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Switch a connected device to the headset profile whenever an application
        opens an input stream. Requires allowHeadsetProfile.
      '';
    };

    codecs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "ldac"
        "aac"
        "sbc_xq"
        "sbc"
      ];
      description = ''
        A2DP codecs offered during negotiation, highest preference first. Drop
        entries here when a device negotiates a codec it handles badly.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.autoSwitchToHeadset -> cfg.allowHeadsetProfile;
        message = "modules.nixos.bluetooth.autoSwitchToHeadset requires allowHeadsetProfile.";
      }
    ];

    hardware.bluetooth = {
      enable = true;
      settings.General = {
        Experimental = true;
        FastConnectable = true;
      }
      // lib.optionalAttrs cfg.allowHeadsetProfile { MultiProfile = "multiple"; };
    };

    services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = cfg.autoSwitchToHeadset;
      };

      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = lib.elem "sbc_xq" cfg.codecs;
        "bluez5.enable-msbc" = cfg.allowHeadsetProfile;
        "bluez5.roles" = roles;
        "bluez5.codecs" = cfg.codecs;
      };

      "monitor.bluez.rules" = [
        {
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          actions.update-props = {
            "bluez5.auto-connect" = roles;
          };
        }
      ];
    };
  };
}
