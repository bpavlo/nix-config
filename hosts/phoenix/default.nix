{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix
    ../../modules/nixos
    ../../users/pavlo.nix
  ];

  modules.nixos = {
    browser-policies.enable = true;
    desktop.enable = true;
    niri.enable = true;
    gaming.enable = true;
    obs.enable = true;
    k3s.enable = true;
  };

  boot.loader.systemd-boot.enable = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  boot.initrd.luks.devices."cryptroot" = {
    allowDiscards = true;
    bypassWorkqueues = true;
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };

  boot.kernelParams = [ "zswap.max_pool_percent=40" ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
  };

  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
    settings.OOM = {
      SwapUsedLimit = "50%";
      DefaultMemoryPressureDurationSec = "10s";
    };
  };

  systemd.slices."user".sliceConfig = {
    ManagedOOMMemoryPressure = "kill";
    ManagedOOMMemoryPressureLimit = "50%";
    MemoryHigh = "28G";
    MemoryMax = "30G";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  services.snapper = {
    snapshotRootOnBoot = false;
    configs = {
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
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    nftables.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = false;
        Settings.AutoConnect = true;
        Rank = {
          BandModifier5Ghz = 2.0;
          BandModifier6Ghz = 2.0;
        };
      };
    };
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  systemd.network.wait-online.enable = false;

  boot.initrd.systemd.network.wait-online.enable = false;

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
