{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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
      aws = {
        format = "on [($profile )($region )($duration)]($style) ";
      };
    };
  };
}
