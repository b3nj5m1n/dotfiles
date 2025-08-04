{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/NixOS/nixos-hardware/archive/61283b30d11f27d5b76439d43f20d0c0c8ff5296.tar.gz";
        sha256 = "0lillvagps6qrl8i4y9axwlaal8fh5ch40v9mm0azm1qz76vxkxf";
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
      allowedTCPPorts = [22 30005 30022];
      allowedUDPPorts = [30005 30022];
    };
  };

  # systemd.network = {
  #   enable = true;
  #   netdevs = {
  #     "50-wg0" = {
  #       netdevConfig = {
  #         Kind = "wireguard";
  #         Name = "wg0";
  #         MTUBytes = "1300";
  #       };
  #       wireguardConfig = {
  #         PrivateKeyFile = "/home/admin/.local/share/wireguard/Server.private";
  #         ListenPort = 30005;
  #       };
  #       wireguardPeers = [
  #         {
  #           wireguardPeerConfig = {
  #             PublicKey = "PtMjckiDgt30S4gzk+fdlJiBJUMaUlP+44KN2G8AbXI=";
  #             AllowedIPs = ["10.0.0.4"];
  #           };
  #         }
  #       ];
  #     };
  #   };
  #   networks.wg0 = {
  #     matchConfig.Name = "wg0";
  #     address = ["10.0.0.4/24"];
  #     networkConfig = {
  #       IPMasquerade = "ipv4";
  #       IPForward = true;
  #     };
  #   };
  # };
  # networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.0.0.0/8"];
      listenPort = 30005;

      preSetup = ''
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
        {
          # Phone
          publicKey = "PtMjckiDgt30S4gzk+fdlJiBJUMaUlP+44KN2G8AbXI=";
          allowedIPs = ["10.0.0.4/32"];
        }
        {
          # Other Person 1
          publicKey = "83chl/v71oe0OkThOpBdsCd0PM7JXmURm1yA8GuDz3I=";
          allowedIPs = ["10.0.0.3/32"];
        }
      ];
    };
  };

  users = {
    mutableUsers = false;
    users."admin" = {
      isNormalUser = true;
      # uid = 1000;
      hashedPassword = "$6$Hvo92DeZuMm2FHLO$ux3upNIqSmFKNW3RGr.Bg8c.ea0qdqYjJQ409T8SY0GTH4pnJTjFeGX43fmWGO5bpihwsk6GCcqp2EjqfQTwY.";
      extraGroups = ["wheel" "jellyfin"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmPDJruFFCbDJx1f0k9OPKe/ZSPWJhbMjpLtLWxXyXz b3nj4m1n@emperor"
      ];
    };
    users."guest" = {
      isNormalUser = true;
      # uid = 511;
      password = "guest";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmPDJruFFCbDJx1f0k9OPKe/ZSPWJhbMjpLtLWxXyXz b3nj4m1n@emperor"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    audiobookshelf
  ];

  systemd.services."audiobookshelf" = {
    enable = true;
    unitConfig = {
      "Description" = "Audiobookshelf Server";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.audiobookshelf}/bin/audiobookshelf --port 30022";
    };
  };
  # networking.firewall.allowedTCPPorts = [30022];

  hardware.raspberry-pi."4".fkms-3d.enable = true;
  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;

  system.stateVersion = "23.05";
}
