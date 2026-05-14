{
  ...
}:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 14;
      theme = "Black Metal (Mayhem)";
      window-padding-x = 10;
      window-padding-y = 10;
      gtk-single-instance = true;
      keybind = [
        "super+t=new_tab"
        "super+w=close_surface"
        "super+ctrl+w=close_tab"

        "super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"

        "super+alt+h=new_split:left"
        "super+alt+j=new_split:down"
        "super+alt+k=new_split:up"
        "super+alt+l=new_split:right"

        "super+ctrl+h=goto_split:left"
        "super+ctrl+j=goto_split:down"
        "super+ctrl+k=goto_split:up"
        "super+ctrl+l=goto_split:right"

        "super+ctrl+shift+h=resize_split:left,10"
        "super+ctrl+shift+j=resize_split:down,10"
        "super+ctrl+shift+k=resize_split:up,10"
        "super+ctrl+shift+l=resize_split:right,10"

        "super+alt+z=toggle_split_zoom"
        "super+alt+0=equalize_splits"
      ];
      window-decoration = "none";
    };
  };
}
