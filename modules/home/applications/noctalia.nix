{
  inputs,
  ...
}:

let
  # Lock screen login box centered on an output; cx/cy are the box center in logical pixels.
  centeredLoginBox = output: width: height: {
    type = "login_box";
    inherit output;
    cx = width / 2.0;
    cy = height / 2.0;
  };
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    customPalettes.Monochrome = import ../../../lib/palettes/monochrome.nix;

    settings = {
      theme = {
        source = "custom";
        custom_palette = "Monochrome";
        templates = {
          enable_builtin_templates = true;
          builtin_ids = [
            "niri"
            "helix"
          ];
        };
      };

      plugins.enabled = [ "noctalia/screen_recorder" ];

      lockscreen.transition = [ ];

      lockscreen_widgets.widget = {
        "lockscreen-login-box@eDP-1" = centeredLoginBox "eDP-1" 1440 960;
        # Serial of the LG UltraGear, so the box follows it across DP-* connectors.
        "lockscreen-login-box@LG" = centeredLoginBox "107NTRL50718" 2560 1440;
      };

      idle.behavior = {
        lock = {
          enabled = true;
          timeout = 300;
          action = "lock";
        };
        "lock-and-suspend" = {
          enabled = true;
          timeout = 600;
          action = "lock_and_suspend";
        };
      };

      wallpaper = {
        enabled = false;
      };

      location = {
        address = "Montreal";
      };

      nightlight = {
        enabled = true;
      };

      control_center = {
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "nightlight"; }
          { type = "power_profile"; }
          { type = "screen_recorder"; }
          { type = "wallpaper"; }
        ];
      };

      shell = {
        clipboard_enabled = false;
        launch_apps_as_systemd_services = true;
        animation.enabled = false;
        panel = {
          control_center_placement = "floating";
          open_near_click_control_center = true;
        };
        launcher = {
          layout = "simple";
          categories = false;
          compact = true;
          show_app_origin_indicator = false;
          ignore_mouse = true;
        };
        session = {
          actions = [
            {
              action = "lock";
              enabled = true;
              shortcut = "1";
            }
            {
              action = "lock_and_suspend";
              enabled = true;
              shortcut = "2";
            }
            {
              action = "command";
              command = "systemctl hibernate";
              label = "Hibernate";
              glyph = "hibernate";
              enabled = true;
              shortcut = "3";
            }
            {
              action = "logout";
              enabled = true;
              shortcut = "4";
            }
            {
              action = "reboot";
              enabled = true;
              shortcut = "5";
            }
            {
              action = "shutdown";
              enabled = true;
              shortcut = "6";
            }
          ];
        };
      };

      bar.main = {
        capsule = true;
        margin_ends = 8;
        start = [
          "workspaces"
          "active_window"
          "media"
        ];
        center = [
          "clock"
          "keyboard_layout"
        ];
        end = [
          "notifications"
          "volume"
          "bluetooth"
          "network"
          "cpu"
          "ram_pct"
          "battery"
          "control-center"
        ];
      };

      widget = {
        media = {
          album_art_only = true;
        };
        keyboard_layout = {
          show_glyph = false;
        };
        battery = {
          display_mode = "graphic";
        };
        ram_pct = {
          type = "sysmon";
          stat = "ram_pct";
        };
      };
    };
  };
}
