{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.commit-mono
  ];

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      coreutils
      git
      neovim
      ripgrep
      bottom
      curl
      wget
      jq
      tree
      eza
      fzf
      fd
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  programs = {
    fish.enable = true;
  };

  system.activationScripts.postActivation.text = "sudo chsh -s ${pkgs.fish}/bin/fish";
}
