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

    customPalettes = {
      Monochrome = {
        dark = {
          mPrimary = "#aaaaaa";
          mOnPrimary = "#111111";
          mSecondary = "#a7a7a7";
          mOnSecondary = "#111111";
          mTertiary = "#cccccc";
          mOnTertiary = "#111111";
          mError = "#dddddd";
          mOnError = "#111111";
          mSurface = "#111111";
          mOnSurface = "#828282";
          mSurfaceVariant = "#191919";
          mOnSurfaceVariant = "#5d5d5d";
          mOutline = "#3c3c3c";
          mShadow = "#000000";
          mHover = "#cccccc";
          mOnHover = "#111111";
          terminal = {
            normal = {
              black = "#1a1a1a";
              red = "#4d4d4d";
              green = "#666666";
              yellow = "#808080";
              blue = "#999999";
              magenta = "#b3b3b3";
              cyan = "#c0c0c0";
              white = "#cccccc";
            };
            bright = {
              black = "#333333";
              red = "#5c5c5c";
              green = "#757575";
              yellow = "#8f8f8f";
              blue = "#a8a8a8";
              magenta = "#c2c2c2";
              cyan = "#d6d6d6";
              white = "#eeeeee";
            };
            foreground = "#cccccc";
            background = "#111111";
            cursor = "#cccccc";
            cursorText = "#111111";
            selectionFg = "#eeeeee";
            selectionBg = "#3c3c3c";
          };
        };
        light = {
          mPrimary = "#555555";
          mOnPrimary = "#eeeeee";
          mSecondary = "#505058";
          mOnSecondary = "#eeeeee";
          mTertiary = "#333333";
          mOnTertiary = "#eeeeee";
          mError = "#222222";
          mOnError = "#efefef";
          mSurface = "#d4d4d4";
          mOnSurface = "#696969";
          mSurfaceVariant = "#e8e8e8";
          mOnSurfaceVariant = "#9e9e9e";
          mOutline = "#c3c3c3";
          mShadow = "#fafafa";
          mHover = "#333333";
          mOnHover = "#eeeeee";
          terminal = {
            normal = {
              black = "#e6e6e6";
              red = "#b3b3b3";
              green = "#999999";
              yellow = "#808080";
              blue = "#666666";
              magenta = "#4d4d4d";
              cyan = "#404040";
              white = "#333333";
            };
            bright = {
              black = "#cccccc";
              red = "#a3a3a3";
              green = "#8a8a8a";
              yellow = "#717171";
              blue = "#585858";
              magenta = "#3d3d3d";
              cyan = "#2a2a2a";
              white = "#111111";
            };
            foreground = "#333333";
            background = "#d4d4d4";
            cursor = "#333333";
            cursorText = "#d4d4d4";
            selectionFg = "#111111";
            selectionBg = "#c3c3c3";
          };
        };
      };
    };

    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "Monochrome";
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
              enabled = false;
            }
            {
              action = "suspend";
              enabled = false;
            }
            {
              action = "hibernate";
              enabled = false;
            }
            {
              action = "reboot";
              enabled = true;
            }
            {
              action = "logout";
              enabled = true;
            }
            {
              action = "shutdown";
              enabled = true;
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
