{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  users.users.pbunakalia = {
    home = "/Users/pbunakalia";
    shell = pkgs.zsh;
  };

  networking = {
    computerName = "darwin";
    hostName = "darwin";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [ git curl coreutils jq wget ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    nix-daemon.enable = true;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [ "koekeishiya/formulae" ];
    masApps = { };
    casks = [
      "amethyst"
      "battery"
      "discord"
      "firefox"
      "karabiner-elements"
      "obs"
      "mullvadvpn"
      "raycast"
      "aws-vpn-client"
      "session-manager-plugin"
      "slack"
      "tor-browser"
      "telegram-desktop"
      "tunnelblick"
    ];
    brews = [
    "skhd"
    "aws-nuke"
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
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
    };
    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh''; # declare shell
    stateVersion = 4;
  };
}
