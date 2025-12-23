{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/common
    ../../modules/nixos/niri.nix
    ../../users/pavlo.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  users.users.pavlo = {
    isNormalUser = true;
    description = "pavlo";
    home = "/home/pavlo";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
  };

  # Lanzaboote Secure Boot
  boot.loader.systemd-boot.enable = false;
  boot.loader.systemd-boot.consoleMode = "max"; # Larger font for high-DPI displays
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # TPM2 auto-unlock for LUKS
  boot.initrd.systemd.enable = true;
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  # LUKS TPM2 unlock
  boot.initrd.luks.devices."cryptroot" = {
    # Device will be set by disko
    allowDiscards = true;
    bypassWorkqueues = true;
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };

  # Memory management
  boot.kernelParams = [ "zswap.enabled=1" ];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # Use 50% of RAM for zram (16GB compressed)
  };

  # Better OOM handling
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
  };

  # Btrfs-specific options
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # Snapshot support
  services.snapper = {
    snapshotRootOnBoot = true;
    configs = {
      root = {
        SUBVOLUME = "/";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "0";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
      home = {
        SUBVOLUME = "/home";
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "0";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };

  networking = {
    hostName = "phoenix";
    networkmanager.enable = true;
    firewall.checkReversePath = "loose"; # Required for Tailscale exit nodes
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.11";
}
