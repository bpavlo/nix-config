{ pkgs, lib, ... }:

let
  qs = "qs";
in
{
  xdg.configFile."niri/config.kdl" = lib.mkIf pkgs.stdenv.isLinux {
    text = ''
      input {
          keyboard {
              xkb {
                  layout "us,ca,ru,ua"
                  options "grp:ctrl_space_toggle"
              }
              repeat-delay 250
              repeat-rate 25
          }

          touchpad {
              tap
              natural-scroll
              click-method "clickfinger"
          }

          mouse {
            natural-scroll
          }
      }

      layout {
          gaps 14
          focus-ring {
            on
            width 2
            active-color "5f8787"
            inactive-color "aaaaaa"
            urgent-color "f3ecd4"
          }
          border {
            off
          }
      }

      cursor {
          xcursor-theme "Adwaita"
          xcursor-size 24
      }

      prefer-no-csd

      output "eDP-1" {
        mode "2880x1920@119.97"
        scale 2.0
        variable-refresh-rate
      }

      output "DP-4" {
        mode "2560x1440@99.3"
        variable-refresh-rate
      }

      animations {
        off
      }

      spawn-at-startup "xwayland-satellite"
      spawn-at-startup "swaybg" "-c" "#000000"
      spawn-at-startup "swayosd-server"

      binds {
          Super+D { spawn "sh" "-c" "qs ipc --pid $(pgrep quickshell) call launcher toggle"; }
          Super+Space { switch-focus-between-floating-and-tiling; }
          Super+Q { close-window; }
          Super+Shift+E { spawn "sh" "-c" "qs ipc --pid $(pgrep quickshell) call sessionMenu toggle"; }
          Super+Shift+P { spawn "sh" "-c" "qs ipc --pid $(pgrep quickshell) call controlCenter toggle"; }
          Super+Return { spawn "ghostty"; }
          Super+X { spawn "swaylock" "-f" "-c" "000000"; }

          Super+S { screenshot; }
          Super+Shift+S { screenshot-screen; }
          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Super+Left { focus-column-left; }
          Super+Right { focus-column-right; }
          Super+Down { focus-window-down; }
          Super+Up { focus-window-up; }
          Super+H { focus-column-left; }
          Super+L { focus-column-right; }
          Super+J { focus-window-down; }
          Super+K { focus-window-up; }

          Super+Ctrl+Left { move-column-left; }
          Super+Ctrl+Right { move-column-right; }
          Super+Ctrl+Down { move-window-down; }
          Super+Ctrl+Up { move-window-up; }
          Super+Ctrl+H { move-column-left; }
          Super+Ctrl+L { move-column-right; }
          Super+Ctrl+J { move-window-down; }
          Super+Ctrl+K { move-window-up; }

          Super+Home { focus-column-first; }
          Super+End { focus-column-last; }

          Super+Shift+Left { focus-monitor-left; }
          Super+Shift+Right { focus-monitor-right; }
          Super+Shift+Down { focus-monitor-down; }
          Super+Shift+Up { focus-monitor-up; }
          Super+Shift+H { focus-monitor-left; }
          Super+Shift+L { focus-monitor-right; }

          Super+Shift+Ctrl+Left { move-column-to-monitor-left; }
          Super+Shift+Ctrl+Right { move-column-to-monitor-right; }
          Super+Shift+Ctrl+Down { move-column-to-monitor-down; }
          Super+Shift+Ctrl+Up { move-column-to-monitor-up; }
          Super+Shift+Ctrl+H { move-column-to-monitor-left; }
          Super+Shift+Ctrl+L { move-column-to-monitor-right; }

          Super+Page_Down { focus-workspace-down; }
          Super+Page_Up { focus-workspace-up; }
          Super+U { focus-workspace-down; }
          Super+I { focus-workspace-up; }
          Super+Ctrl+Page_Down { move-column-to-workspace-down; }
          Super+Ctrl+Page_Up { move-column-to-workspace-up; }
          Super+Ctrl+U { move-column-to-workspace-down; }
          Super+Ctrl+I { move-column-to-workspace-up; }

          Super+Shift+Page_Down { move-workspace-down; }
          Super+Shift+Page_Up { move-workspace-up; }
          Super+Shift+U { move-workspace-down; }
          Super+Shift+I { move-workspace-up; }

          Super+1 { focus-workspace 1; }
          Super+2 { focus-workspace 2; }
          Super+3 { focus-workspace 3; }
          Super+4 { focus-workspace 4; }
          Super+5 { focus-workspace 5; }
          Super+6 { focus-workspace 6; }
          Super+7 { focus-workspace 7; }
          Super+8 { focus-workspace 8; }
          Super+9 { focus-workspace 9; }
          Super+Ctrl+1 { move-column-to-workspace 1; }
          Super+Ctrl+2 { move-column-to-workspace 2; }
          Super+Ctrl+3 { move-column-to-workspace 3; }
          Super+Ctrl+4 { move-column-to-workspace 4; }
          Super+Ctrl+5 { move-column-to-workspace 5; }
          Super+Ctrl+6 { move-column-to-workspace 6; }
          Super+Ctrl+7 { move-column-to-workspace 7; }
          Super+Ctrl+8 { move-column-to-workspace 8; }
          Super+Ctrl+9 { move-column-to-workspace 9; }

          Super+Comma { consume-window-into-column; }
          Super+Period { expel-window-from-column; }

          Super+BracketLeft { consume-or-expel-window-left; }
          Super+BracketRight { consume-or-expel-window-right; }

          Super+R { switch-preset-column-width; }
          Super+Shift+R { switch-preset-window-height; }
          Super+F { maximize-column; }
          Super+Shift+F { fullscreen-window; }

          Super+Minus { set-column-width "-10%"; }
          Super+Equal { set-column-width "+10%"; }
          Super+Shift+Minus { set-window-height "-10%"; }
          Super+Shift+Equal { set-window-height "+10%"; }

          Super+Shift+Space { toggle-window-floating; }

          Super+O { toggle-overview; }

          // XF86 Media keys (Function keys on Framework laptop)
          // Using swayosd for OSD feedback
          XF86AudioRaiseVolume { spawn "swayosd-client" "--output-volume" "raise"; }
          XF86AudioLowerVolume { spawn "swayosd-client" "--output-volume" "lower"; }
          XF86AudioMute { spawn "swayosd-client" "--output-volume" "mute-toggle"; }
          XF86AudioMicMute { spawn "swayosd-client" "--input-volume" "mute-toggle"; }
          XF86MonBrightnessUp { spawn "swayosd-client" "--brightness" "raise"; }
          XF86MonBrightnessDown { spawn "swayosd-client" "--brightness" "lower"; }
          XF86AudioPlay { spawn "playerctl" "play-pause"; }
          XF86AudioNext { spawn "playerctl" "next"; }
          XF86AudioPrev { spawn "playerctl" "previous"; }
      }
    '';
  };

  programs.swaylock = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };

  services.swayidle = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    events = {
      before-sleep = "swaylock -f -c 000000";
      lock = "swaylock -f -c 000000";
    };
    timeouts = [
      {
        timeout = 300;
        command = "loginctl lock-session";
      }
      {
        timeout = 600;
        command = "systemctl suspend";
      }
    ];
  };

  home.sessionVariables = lib.mkIf pkgs.stdenv.isLinux {
    WAYLAND_DISPLAY = "wayland-1";
    XDG_SESSION_TYPE = "wayland";
  };
}
