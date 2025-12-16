{ pkgs, ... }:

{
  # Hardware and platform-specific configuration

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.commit-mono
  ];

  environment = {
    shells = with pkgs; [ zsh ];
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

  # Shell activation script
  system.activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh'';
}
