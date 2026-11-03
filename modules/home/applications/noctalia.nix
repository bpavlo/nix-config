{
  inputs,
  ...
}:

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
        mode = "dark";
        source = "custom";
        custom_palette = "Monochrome";
      };

      lockscreen = {
        enabled = true;
        lock_before_suspend = true;
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

      weather = {
        enabled = true;
      };

      nightlight = {
        enabled = true;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      dock = {
        enabled = false;
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
        panel = {
          control_center_placement = "floating";
          control_center_position = "auto";
          open_near_click_control_center = true;
        };
        launcher = {
          categories = true;
          show_icons = true;
          app_grid = false;
          sort_by_usage = true;
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
#              variant = "destructive";
              enabled = true;
              shortcut = "6";
            }
          ];
        };
      };

      bar.main = {
        position = "top";
        capsule = true;
        capsule_opacity = 1.0;
        margin_ends = 8;
        margin_edge = 0;
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
          "cpu_usage"
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
          show_icon = false;
        };
        battery = {
          display_mode = "graphic";
        };
        cpu_usage = {
          type = "sysmon";
          stat = "cpu_usage";
        };
        ram_pct = {
          type = "sysmon";
          stat = "ram_pct";
        };
      };
    };
  };
}
