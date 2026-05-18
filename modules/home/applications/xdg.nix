{ ... }:

let
  browser = "brave-browser.desktop";
  fileManager = "org.gnome.Nautilus.desktop";
  imageViewer = "org.gnome.gThumb.desktop";
  videoPlayer = "mpv.desktop";
  pdfReader = "org.gnome.Papers.desktop";
  textEditor = "ghostty-nvim.desktop";
  terminal = "com.mitchellh.ghostty.desktop";
in
{
  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;
    dataFile."applications/mimeapps.list".force = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        # Directories / file manager
        "inode/directory" = [ fileManager ];

        # Terminal emulator
        "x-scheme-handler/terminal" = [ terminal ];

        # Web browser
        "text/html" = [ browser ];
        "x-scheme-handler/http" = [ browser ];
        "x-scheme-handler/https" = [ browser ];
        "x-scheme-handler/about" = [ browser ];
        "x-scheme-handler/unknown" = [ browser ];
        "application/xhtml+xml" = [ browser ];

        # PDF / documents
        "application/pdf" = [ pdfReader ];
        "application/epub+zip" = [ pdfReader ];
        "application/x-cbz" = [ "org.pwmt.zathura-cb.desktop" ];
        "application/x-cbr" = [ "org.pwmt.zathura-cb.desktop" ];
        "application/postscript" = [ "org.pwmt.zathura-ps.desktop" ];
        "image/vnd.djvu" = [ "org.pwmt.zathura-djvu.desktop" ];

        # Images
        "image/png" = [ imageViewer ];
        "image/jpeg" = [ imageViewer ];
        "image/gif" = [ imageViewer ];
        "image/webp" = [ imageViewer ];
        "image/svg+xml" = [ imageViewer ];
        "image/bmp" = [ imageViewer ];
        "image/tiff" = [ imageViewer ];
        "image/avif" = [ imageViewer ];
        "image/heif" = [ imageViewer ];
        "image/heic" = [ imageViewer ];

        # Video
        "video/mp4" = [ videoPlayer ];
        "video/x-matroska" = [ videoPlayer ];
        "video/webm" = [ videoPlayer ];
        "video/x-msvideo" = [ videoPlayer ];
        "video/quicktime" = [ videoPlayer ];
        "video/mpeg" = [ videoPlayer ];
        "video/ogg" = [ videoPlayer ];
        "video/x-flv" = [ videoPlayer ];

        # Audio
        "audio/mpeg" = [ videoPlayer ];
        "audio/mp4" = [ videoPlayer ];
        "audio/flac" = [ videoPlayer ];
        "audio/ogg" = [ videoPlayer ];
        "audio/wav" = [ videoPlayer ];
        "audio/x-wav" = [ videoPlayer ];
        "audio/webm" = [ videoPlayer ];
        "audio/aac" = [ videoPlayer ];
        "audio/opus" = [ videoPlayer ];

        # Plain text
        "text/plain" = [ textEditor ];
        "text/x-csrc" = [ textEditor ];
        "text/x-python" = [ textEditor ];
        "text/x-shellscript" = [ textEditor ];
        "text/x-makefile" = [ textEditor ];
        "text/markdown" = [ textEditor ];
        "application/json" = [ textEditor ];
        "application/xml" = [ textEditor ];
        "application/x-yaml" = [ textEditor ];
        "application/toml" = [ textEditor ];
      };
    };

    # Override Telegram's desktop entry to use the XDG portal file picker
    # instead of the GTK2 platform theme which gives the old-style Qt dialog.
    desktopEntries = {
      "ghostty-nvim" = {
        name = "Neovim (Ghostty)";
        genericName = "Text Editor";
        exec = "ghostty -e nvim %F";
        icon = "nvim";
        terminal = false;
        type = "Application";
        categories = [
          "Utility"
          "TextEditor"
          "Development"
        ];
        mimeType = [
          "text/plain"
          "text/markdown"
          "text/x-csrc"
          "text/x-c++src"
          "text/x-python"
          "text/x-shellscript"
          "text/x-makefile"
          "text/x-lua"
          "text/x-go"
          "text/x-rust"
          "text/x-nix"
          "application/json"
          "application/xml"
          "application/x-yaml"
          "application/toml"
        ];
        settings = {
          StartupNotify = "true";
          StartupWMClass = "com.mitchellh.ghostty";
        };
      };

      "org.telegram.desktop" = {
        name = "Telegram";
        exec = "env QT_QPA_PLATFORMTHEME=xdgdesktopportal Telegram -- %U";
        icon = "org.telegram.desktop";
        terminal = false;
        categories = [
          "Chat"
          "Network"
          "InstantMessaging"
          "Qt"
        ];
        mimeType = [
          "x-scheme-handler/tg"
          "x-scheme-handler/tonsite"
        ];
        settings = {
          StartupWMClass = "TelegramDesktop";
          DBusActivatable = "true";
          SingleMainWindow = "true";
          X-GNOME-UsesNotifications = "true";
        };
      };
    };
  };
}
