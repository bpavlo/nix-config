{ ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
    shellWrapperName = "y";

    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        wrap = "no";
        tab_size = 2;
        max_width = 1000;
        max_height = 1000;
        cache_dir = "";
        image_filter = "lanczos3";
        image_quality = 90;
        sixel_fraction = 15;
        ueberzug_scale = 1;
      };

      opener = {
        edit = [
          {
            run = ''$EDITOR "$@"'';
            block = true;
            for = "linux";
          }
        ];
        open = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
            for = "linux";
          }
        ];
        play = [
          {
            run = ''mpv --force-window "$@"'';
            orphan = true;
            for = "linux";
          }
        ];
        view-image = [
          {
            run = ''gthumb "$@"'';
            orphan = true;
            for = "linux";
          }
        ];
        view-pdf = [
          {
            run = ''papers "$@"'';
            orphan = true;
            for = "linux";
          }
        ];
        extract = [
          {
            run = ''unar "$1"'';
            desc = "Extract here";
            for = "linux";
          }
        ];
        reveal = [
          {
            run = ''nautilus "$1"'';
            desc = "Reveal in Nautilus";
            orphan = true;
            for = "linux";
          }
        ];
      };

      open = {
        rules = [
          {
            mime = "inode/directory";
            use = [
              "edit"
              "open"
              "reveal"
            ];
          }
          {
            mime = "text/*";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "image/*";
            use = [
              "view-image"
              "open"
              "reveal"
            ];
          }
          {
            mime = "video/*";
            use = [
              "play"
              "open"
              "reveal"
            ];
          }
          {
            mime = "audio/*";
            use = [
              "play"
              "open"
              "reveal"
            ];
          }
          {
            mime = "application/pdf";
            use = [
              "view-pdf"
              "open"
              "reveal"
            ];
          }
          {
            mime = "application/{,g,b}zip";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-{tar,7z*,rar,xz,bzip*}";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/{json,xml,toml,x-yaml,x-shellscript}";
            use = [
              "edit"
              "open"
              "reveal"
            ];
          }
          {
            mime = "*";
            use = [
              "open"
              "reveal"
            ];
          }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "g"
            "h"
          ];
          run = "cd ~";
          desc = "Go home";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "cd ~/.config";
          desc = "Go to ~/.config";
        }
        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/nix-config";
          desc = "Go to nix-config";
        }
        {
          on = [
            "g"
            "d"
          ];
          run = "cd ~/Downloads";
          desc = "Go to Downloads";
        }
        {
          on = "<C-r>";
          run = ''shell 'nautilus "$0"' --orphan'';
          desc = "Reveal in Nautilus";
        }
        {
          on = "<C-y>";
          run = ''shell 'echo -n "$0" | wl-copy' --confirm'';
          desc = "Copy path to clipboard";
        }
      ];
    };
  };
}
