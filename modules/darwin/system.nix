{ ... }:

{
  system.defaults = {
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 14;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      static-only = true;
    };
    finder = {
      _FXShowPosixPathInTitle = true;
      CreateDesktop = false;
      FXPreferredViewStyle = "Nlsv";
      QuitMenuItem = true;
    };
    screencapture.disable-shadow = true;
  };
}
