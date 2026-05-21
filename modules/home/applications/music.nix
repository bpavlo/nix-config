{
  config,
  pkgs,
  ...
}:

{
  programs.beets = {
    enable = true;
    package = pkgs.beets.overridePythonAttrs (old: {
      propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [ pkgs.python3Packages.beetcamp ];
    });

    settings = {
      directory = "${config.home.homeDirectory}/Music";
      library = "${config.xdg.dataHome}/beets/library.db";

      plugins = "musicbrainz fetchart embedart replaygain scrub info missing smartplaylist bandcamp duplicates play mbsync inline";

      import = {
        copy = true;
        move = false;
        write = true;
        incremental = true;
        duplicate_action = "merge";
      };

      paths = {
        default = "$albumartist/$album%aunique{} ($year)/$track $title";
        singleton = "Non-Album/$artist/$title";
        comp = "Compilations/$album%aunique{} ($year)/$track $title";
      };

      embedart.auto = true;
      replaygain.backend = "ffmpeg";
    };
  };

  home.packages = with pkgs; [
    picard
    chromaprint
  ];
}
