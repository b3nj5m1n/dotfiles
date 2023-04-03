{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    outputs.nixosModules.base
    outputs.nixosModules.shell
    outputs.nixosModules.bash
    outputs.nixosModules.nix
    outputs.nixosModules.python
    outputs.nixosModules.jellyfin

    "${
      fetchTarball {
        url = "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz";
        sha256 = "06g0061xm48i5w7gz5sm5x5ps6cnipqv1m483f8i9mmhlz77hvlw";
      }
    }/raspberry-pi/4"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
    "/mnt/stick1" = {
      device = "/dev/disk/by-uuid/0f2ca358-30b3-4d7d-8fa4-84598166d10b";
      fsType = "ext4";
      options = ["nofail"];
    };
    "/mnt/stick2" = {
      device = "/dev/disk/by-uuid/14f6c3d0-484d-4b49-98f7-18af3229366e";
      fsType = "ext4";
      options = ["nofail"];
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-linux";
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
    ];
    config = {
      allowUnfree = false;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "chinstrap";
    nat = {
      enable = true;
      externalInterface = "end0";
      internalInterfaces = ["wg0"];
    };
    nftables = {
      enable = true;
      # rulesetFile = ../../files/nftables/config;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 30005];
      allowedUDPPorts = [30005];
    };
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.0.0.0/8"];
      listenPort = 30005;

      postSetup = ''
        ${pkgs.nftables}/bin/nft add rule nixos-nat post ip saddr 10.0.0.0/8 oif end0 masquerade
      '';
      postShutdown = ''
        ${pkgs.nftables}/bin/nft delete rule nixos-nat post ip saddr 10.0.0.0/8 oif end0 masquerade
      '';

      privateKeyFile = "/home/admin/.local/share/wireguard/Server.private";

      peers = [
        {
          # Desktop
          publicKey = "s0oldHe6jxMKQ3SwTboPGlz3tEAZ5NIrQEYY455oajk=";
          allowedIPs = ["10.0.0.1/32"];
        }
        {
          # Android
          publicKey = "sgWsqw4Y3d21XrkysAgxQbLUL3v2YlgJfuMggvvrMU0=";
          allowedIPs = ["10.0.0.2/32"];
        }
      ];
    };
  };

  users = {
    mutableUsers = false;
    users."admin" = {
      isNormalUser = true;
      hashedPassword = "$6$Hvo92DeZuMm2FHLO$ux3upNIqSmFKNW3RGr.Bg8c.ea0qdqYjJQ409T8SY0GTH4pnJTjFeGX43fmWGO5bpihwsk6GCcqp2EjqfQTwY.";
      extraGroups = ["wheel" "jellyfin"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmPDJruFFCbDJx1f0k9OPKe/ZSPWJhbMjpLtLWxXyXz b3nj4m1n@emperor"
      ];
    };
    users."guest" = {
      isNormalUser = true;
      password = "guest";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmPDJruFFCbDJx1f0k9OPKe/ZSPWJhbMjpLtLWxXyXz b3nj4m1n@emperor"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
  ];

  hardware.raspberry-pi."4".fkms-3d.enable = true;

  system.stateVersion = "23.05";
}
