{ ... }:

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      default_shell = "fish";
      theme = "monochrome";
      simplified_ui = true;
      copy_command = "wl-copy";
      copy_clipboard = "system";
      copy_on_select = true;
      show_startup_tips = false;
      show_release_notes = false;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 10000;
      serialization_interval = 60;
      mouse_mode = true;
      scroll_buffer_size = 100000;
      on_force_close = "detach";
      ui.pane_frames = {
        hide_session_name = true;
        rounded_corners = true;
      };
    };
  };

  xdg.configFile."zellij/themes/monochrome.kdl".text = ''
    themes {
        monochrome {
            text_unselected {
                base 130 130 130
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            text_selected {
                base 204 204 204
                background 25 25 25
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            ribbon_unselected {
                base 130 130 130
                background 25 25 25
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 95 135 135
                emphasis_3 221 221 221
            }
            ribbon_selected {
                base 17 17 17
                background 238 204 108
                emphasis_0 95 135 135
                emphasis_1 17 17 17
                emphasis_2 60 60 60
                emphasis_3 221 221 221
            }
            table_title {
                base 238 204 108
                background 17 17 17
                emphasis_0 204 204 204
                emphasis_1 95 135 135
                emphasis_2 170 170 170
                emphasis_3 221 221 221
            }
            table_cell_unselected {
                base 130 130 130
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            table_cell_selected {
                base 204 204 204
                background 25 25 25
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            list_unselected {
                base 130 130 130
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            list_selected {
                base 204 204 204
                background 25 25 25
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 221 221 221
            }
            frame_unselected {
                base 60 60 60
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 95 135 135
                emphasis_2 204 204 204
                emphasis_3 17 17 17
            }
            frame_selected {
                base 95 135 135
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 204 204 204
                emphasis_2 221 221 221
                emphasis_3 17 17 17
            }
            frame_highlight {
                base 238 204 108
                background 17 17 17
                emphasis_0 221 221 221
                emphasis_1 238 204 108
                emphasis_2 238 204 108
                emphasis_3 238 204 108
            }
            exit_code_success {
                base 95 135 135
                background 17 17 17
                emphasis_0 204 204 204
                emphasis_1 17 17 17
                emphasis_2 238 204 108
                emphasis_3 130 130 130
            }
            exit_code_error {
                base 221 221 221
                background 17 17 17
                emphasis_0 238 204 108
                emphasis_1 17 17 17
                emphasis_2 17 17 17
                emphasis_3 17 17 17
            }
            multiplayer_user_colors {
                player_1 238 204 108
                player_2 95 135 135
                player_3 204 204 204
                player_4 221 221 221
                player_5 170 170 170
                player_6 167 167 167
                player_7 130 130 130
                player_8 60 60 60
                player_9 25 25 25
                player_10 255 255 255
            }
        }
    }
  '';
}
