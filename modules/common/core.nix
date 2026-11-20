{ pkgs, ... }:

{
  programs.fish.enable = true;
  
  programs.nh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    lsof
    curl
    wget
    jq
    gnumake
    gcc
  ];
}
