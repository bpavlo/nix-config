{
  inputs,
  ...
}:

{
  imports = [
    ./applications
    ./desktop.nix
    ./dev.nix
    ./fish.nix
    ./git.nix
    ./packages.nix
    ./ssh.nix
    inputs.zen-browser.homeModules.twilight
  ];

  home.stateVersion = "25.11";

  manual.manpages.enable = false;

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    BROWSER = "zen-twilight";
    TERMINAL = "ghostty";
    TF_PLUGIN_CACHE_DIR = "$HOME/.terraform.d/plugin-cache";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    home-manager.enable = true;

    zen-browser = {
      enable = true;
    };
  };

  services = {
    syncthing = {
      enable = true;
    };
  };
}
