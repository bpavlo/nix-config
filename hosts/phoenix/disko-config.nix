{ ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                passwordFile = "/tmp/secret.key"; # Create this file during installation
                settings = {
                  # Boot-time unlock settings
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
                # LUKS2 creation options (used during formatting)
                extraFormatArgs = [
                  "--type=luks2"
                  "--cipher=aes-xts-plain64"
                  "--hash=sha256"
                  "--iter-time=1000"
                  "--key-size=256"
                  "--pbkdf=argon2id"
                  "--sector-size=4096"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "--label"
                    "nixos"
                  ];
                  subvolumes = {
                    # Root subvolume
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                        "ssd"
                      ];
                    };

                    # Home directory
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                        "ssd"
                      ];
                    };

                    # Nix store - heavily compressed as packages don't change
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd:3"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                        "ssd"
                      ];
                    };

                    # Logs - less compression, may be frequently written
                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                        "ssd"
                      ];
                    };

                    # Snapshots directory
                    "@snapshots" = {
                      mountpoint = "/.snapshots";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                        "ssd"
                      ];
                    };

                    # Swap subvolume - no compression, no CoW
                    "@swap" = {
                      mountpoint = "/swap";
                      mountOptions = [
                        "noatime"
                        "nodatacow"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
