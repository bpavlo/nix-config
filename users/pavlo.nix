{
  pkgs,
  vars,
  inputs,
  ...
}:

{
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.fullName;
    home = "/home/${vars.username}";
    shell = pkgs.fish;
    extraGroups = [
      "gamemode"
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "docker"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username} = {
      imports = [ ../modules/home ];
      modules.home = {
        dev.enable = true;
        desktop.enable = true;
      };
    };
    backupFileExtension = "hm-backup";
  };
}
