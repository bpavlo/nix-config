{ pkgs, lib, ... }:

{
  programs.anyrun = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

    config = {
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      height = { fraction = 0.0; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libniri_focus.so"
      ];
    };

    extraCss = ''
      * {
        font-family: "Inter", sans-serif;
        font-size: 1.1rem;
        all: unset;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      box#main {
        background: rgba(30, 30, 30, 0.95);
        border: 2px solid #5f8787;
        border-radius: 12px;
        padding: 12px;
      }

      #entry {
        background: rgba(50, 50, 50, 0.9);
        border-radius: 8px;
        padding: 8px;
        margin-bottom: 8px;
        border: none;
      }

      #match {
        padding: 6px;
        border-radius: 6px;
        background: transparent;
      }

      #match:selected {
        background: rgba(95, 135, 135, 0.6);
      }

      list > #match {
        background: transparent;
      }
    '';
  };
}
