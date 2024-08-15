{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  users.users.pvl = {
    home = "/Users/pvl";
    shell = pkgs.zsh;
  };

  networking = {
    computerName = "darwin";
    hostName = "darwin";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [
      git
      curl
      coreutils
      jq
      wget
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    nix-daemon.enable = true;
    skhd = {
      enable = true;
      skhdConfig = builtins.readFile ./skhdrc;
    };
    yabai = {
      enable = true;
      extraConfig = builtins.readFile ./yabairc;
    };
    tailscale = {
      enable = true;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    casks = [
      "appcleaner"
      "battery"
      "brave-browser"
      "firefox"
      "obs"
      "mullvadvpn"
      "raycast"
      "aws-vpn-client"
      "session-manager-plugin"
      "slack"
      "tor-browser"
      "telegram-desktop"
      "karabiner-elements"
      "shortcat"
      "openvpn-connect"
      "whisky"
      "steam"
      "heroic"
      "discord"
      "spaceid"
    ];
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    defaults = {
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
    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh''; # declare shell
    stateVersion = 4;
  };
}
