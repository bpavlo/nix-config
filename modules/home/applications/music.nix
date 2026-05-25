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

      plugins = "musicbrainz fetchart embedart replaygain scrub info missing smartplaylist bandcamp duplicates play mbsync inline convert";

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

      convert = {
        auto = false;
        dest = "${config.home.homeDirectory}/mp3";
        threads = 4;
        embed = true;
        copy_album_art = true;
        album_art_maxwidth = 1000;
        format = "mp3";
        formats.mp3 = {
          command = "${pkgs.jellyfin-ffmpeg}/bin/ffmpeg -i $source -y -map 0:a -map_metadata 0 -c:a libmp3lame -b:a 320k -compression_level 0 -ar 44100 $dest";
          extension = "mp3";
        };
        paths.default = "$albumartist/$album%aunique{} ($year)/$track $title";
      };
    };
  };

  home.packages = with pkgs; [
    picard
    chromaprint
  ];
}
