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
      command = "tmux new-session -A -s main";
      keybind = [
        "super+w=close_tab"
        "super+t=new_tab"
        "super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"
      ];
      window-decoration = "none";
    };
  };
}
