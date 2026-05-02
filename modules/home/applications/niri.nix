{ pkgs, lib, ... }:

let
  spawnQs = method: "qs ipc --pid $(pgrep quickshell) call ${method} toggle";
  mkSpawnBind = cmd: { action.spawn = [ "sh" "-c" cmd ]; };
  mkActionBind = actionName: { action.${actionName} = [ ]; };
in
{
  programs.niri.settings = lib.mkIf pkgs.stdenv.isLinux {
    input = {
      keyboard = {
        xkb = {
          layout = "us,ca,ru,ua";
          options = "grp:ctrl_space_toggle";
        };
        repeat-delay = 250;
        repeat-rate = 25;
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        click-method = "clickfinger";
      };
      mouse.natural-scroll = true;
    };

    layout = {
      gaps = 14;
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#5f8787";
        inactive.color = "#aaaaaa";
        urgent.color = "#f3ecd4";
      };
      border.enable = false;
    };

    cursor = {
      theme = "Adwaita";
      size = 24;
    };

    prefer-no-csd = true;

    outputs = {
      "eDP-1" = {
        mode = {
          width = 2880;
          height = 1920;
          refresh = 119.97;
        };
        scale = 2.0;
        variable-refresh-rate = "on-demand";
        position = {
          x = 0;
          y = 0;
        };
      };

      "DP-4" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 143.973;
        };
        scale = 1.0;
        variable-refresh-rate = "on-demand";
        position = {
          x = 0;
          y = 0;
        };
      };
    };

    animations.enable = false;

    workspaces = {
      "1-term" = { };
      "2-web" = { };
      "3-chat" = { };
    };

    window-rules = [
      {
        matches = [ { app-id = "^steam$"; } ];
        open-floating = true;
      }
      {
        matches = [ { app-id = "^steam_.*"; } ];
        open-floating = true;
      }
      {
        matches = [ { app-id = "^battle.net$"; } ];
        open-floating = true;
      }
      {
        matches = [ { title = "^Battle.net$"; } ];
        open-floating = true;
      }
      {
        matches = [
          {
            app-id = "^zen$|^brave-browser$|brave-origin-beta$";
          }
        ];
        open-on-workspace = "2-web";
      }
      {
        matches = [
          {
            app-id = "^Slack$|^org.telegram.desktop$|^vesktop$";
          }
        ];
        open-on-workspace = "3-chat";
      }
    ];

    spawn-at-startup = [
      {
        argv = [
          "swaybg"
          "-c"
          "#000000"
        ];
      }
      {
        argv = [ "noctalia-shell" ];
      }
    ];

    binds = {
      "Super+D" = mkSpawnBind (spawnQs "launcher");
      "Super+Space" = mkActionBind "switch-focus-between-floating-and-tiling";
      "Super+Q" = mkActionBind "close-window";
      "Super+Shift+E" = mkSpawnBind (spawnQs "sessionMenu");
      "Super+Shift+P" = mkSpawnBind (spawnQs "controlCenter");
      "Super+Return".action.spawn = "ghostty";
      "Super+Shift+Return".action.spawn = [ "ghostty" "--class" "ghostty-anywhere" ];

      "Super+WheelScrollLeft".action."focus-column-left" = [ ];
      "Super+WheelScrollRight".action."focus-column-right" = [ ];

      "Super+X".action.spawn = [ "${pkgs.swaylock}/bin/swaylock" "-f" "-c" "000000" ];
      "Super+Shift+X".action.spawn = [ "systemctl" "suspend" ];
      "Super+Ctrl+X".action.spawn = [ "systemctl" "hibernate" ];

      "Super+S" = mkActionBind "screenshot";
      "Super+Shift+S" = mkActionBind "screenshot-screen";
      "Print" = mkActionBind "screenshot";
      "Ctrl+Print" = mkActionBind "screenshot-screen";
      "Alt+Print" = mkActionBind "screenshot-window";

      "Super+Left" = mkActionBind "focus-column-left";
      "Super+Right" = mkActionBind "focus-column-right";
      "Super+Down" = mkActionBind "focus-window-down";
      "Super+Up" = mkActionBind "focus-window-up";
      "Super+H" = mkActionBind "focus-column-left";
      "Super+L" = mkActionBind "focus-column-right";
      "Super+J" = mkActionBind "focus-window-down";
      "Super+K" = mkActionBind "focus-window-up";

      "Super+Shift+Left" = mkActionBind "move-column-left";
      "Super+Shift+Right" = mkActionBind "move-column-right";
      "Super+Shift+Down" = mkActionBind "move-window-down";
      "Super+Shift+Up" = mkActionBind "move-window-up";
      "Super+Shift+H" = mkActionBind "move-column-left";
      "Super+Shift+L" = mkActionBind "move-column-right";
      "Super+Shift+J" = mkActionBind "move-window-down";
      "Super+Shift+K" = mkActionBind "move-window-up";

      "Super+Home" = mkActionBind "focus-column-first";
      "Super+End" = mkActionBind "focus-column-last";

      "Super+Ctrl+Left" = mkActionBind "focus-monitor-left";
      "Super+Ctrl+Right" = mkActionBind "focus-monitor-right";
      "Super+Ctrl+Down" = mkActionBind "focus-monitor-down";
      "Super+Ctrl+Up" = mkActionBind "focus-monitor-up";
      "Super+Ctrl+H" = mkActionBind "focus-monitor-left";
      "Super+Ctrl+L" = mkActionBind "focus-monitor-right";

      "Super+Shift+Ctrl+Left" = mkActionBind "move-column-to-monitor-left";
      "Super+Shift+Ctrl+Right" = mkActionBind "move-column-to-monitor-right";
      "Super+Shift+Ctrl+Down" = mkActionBind "move-column-to-monitor-down";
      "Super+Shift+Ctrl+Up" = mkActionBind "move-column-to-monitor-up";
      "Super+Shift+Ctrl+H" = mkActionBind "move-column-to-monitor-left";
      "Super+Shift+Ctrl+L" = mkActionBind "move-column-to-monitor-right";

      "Super+Page_Down" = mkActionBind "focus-workspace-down";
      "Super+Page_Up" = mkActionBind "focus-workspace-up";
      "Super+U" = mkActionBind "focus-workspace-down";
      "Super+I" = mkActionBind "focus-workspace-up";
      "Super+Ctrl+Page_Down" = mkActionBind "move-column-to-workspace-down";
      "Super+Ctrl+Page_Up" = mkActionBind "move-column-to-workspace-up";
      "Super+Ctrl+U" = mkActionBind "move-column-to-workspace-down";
      "Super+Ctrl+I" = mkActionBind "move-column-to-workspace-up";

      "Super+Shift+Page_Down" = mkActionBind "move-workspace-down";
      "Super+Shift+Page_Up" = mkActionBind "move-workspace-up";
      "Super+Shift+U" = mkActionBind "move-workspace-down";
      "Super+Shift+I" = mkActionBind "move-workspace-up";

      "Super+1".action."focus-workspace" = 1;
      "Super+2".action."focus-workspace" = 2;
      "Super+3".action."focus-workspace" = 3;
      "Super+4".action."focus-workspace" = 4;
      "Super+5".action."focus-workspace" = 5;
      "Super+6".action."focus-workspace" = 6;
      "Super+7".action."focus-workspace" = 7;
      "Super+8".action."focus-workspace" = 8;
      "Super+9".action."focus-workspace" = 9;
      "Super+Ctrl+1".action."move-column-to-workspace" = 1;
      "Super+Ctrl+2".action."move-column-to-workspace" = 2;
      "Super+Ctrl+3".action."move-column-to-workspace" = 3;
      "Super+Ctrl+4".action."move-column-to-workspace" = 4;
      "Super+Ctrl+5".action."move-column-to-workspace" = 5;
      "Super+Ctrl+6".action."move-column-to-workspace" = 6;
      "Super+Ctrl+7".action."move-column-to-workspace" = 7;
      "Super+Ctrl+8".action."move-column-to-workspace" = 8;
      "Super+Ctrl+9".action."move-column-to-workspace" = 9;

      "Super+Comma" = mkActionBind "consume-window-into-column";
      "Super+Period" = mkActionBind "expel-window-from-column";

      "Super+BracketLeft" = mkActionBind "consume-or-expel-window-left";
      "Super+BracketRight" = mkActionBind "consume-or-expel-window-right";

      "Super+R" = mkActionBind "switch-preset-column-width";
      "Super+Shift+R" = mkActionBind "switch-preset-window-height";
      "Super+F" = mkActionBind "maximize-column";
      "Super+Shift+F" = mkActionBind "fullscreen-window";

      "Super+Minus".action."set-column-width" = "-10%";
      "Super+Equal".action."set-column-width" = "+10%";
      "Super+Shift+Minus".action."set-window-height" = "-10%";
      "Super+Shift+Equal".action."set-window-height" = "+10%";

      "Super+Shift+Space" = mkActionBind "toggle-window-floating";
      "Super+O" = mkActionBind "toggle-overview";

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" ];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-" ];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [ "brightnessctl" "set" "5%+" ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [ "brightnessctl" "set" "5%-" ];
      };
      "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
      "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
      "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
    };
  };

  services.swayidle = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 600;
        command = "systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
    ];
  };

  home.sessionVariables = lib.mkIf pkgs.stdenv.isLinux {
    WAYLAND_DISPLAY = "wayland-1";
    XDG_SESSION_TYPE = "wayland";
  };
}
