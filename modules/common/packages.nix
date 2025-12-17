{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    ripgrep
    bottom

    curl
    wget
    jq
    tree
  ];
}
