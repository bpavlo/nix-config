{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core — useful on any host with a user
    opencode
    openssl
    rmpc
    typst
    streamrip
    jellyfin-ffmpeg

    # CLI utilities
    bottom
    eza
    fastfetch
    fd
    gnupg
    mkpasswd
    nmap
    normcap
    ripgrep
    tree
    xdg-utils
    yamllint
    yazi
    yt-dlp

    # Archives
    unar
    p7zip

    # Nix tools
    nix-du
    nix-top
    nix-tree

    # Secrets management
    sops
    ssh-to-age
  ];
}
