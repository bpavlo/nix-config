{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    ripgrep
    bottom
    lsof

    curl
    wget
    jq
    tree

    gnumake
    gcc
  ];
}
