{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$character"
        "$aws"
      ];
      git_branch = {
        style = "bold yellow";
      };
    };
  };
}
