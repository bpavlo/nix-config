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
    users.pavlo = import ../modules/home;
  };
}
