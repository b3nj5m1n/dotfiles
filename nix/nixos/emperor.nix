{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../hardware/newpc.nix
  ];

  # services.desktopManager.cosmic.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
      # outputs.overlays.hyprland
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "python-2.7.18.6"
        "electron-27.3.11"
        "libsoup-2.74.3"
      ];
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
      # substituters = ["https://hyprland.cachix.org"];
      # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      http-connections = 128;
      max-substitution-jobs = 128;
      max-jobs = "auto";
      substituters = [
        "https://nix-community.cachix.org"
        # "https://cache.nixos.org"
      ];
      trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # Ricefields
  ricefields.sway.useSwayFX = true;

  programs.kdeconnect.enable = true;

  networking.hostName = "emperor";

  boot.supportedFilesystems = ["btrfs"];
  hardware.enableAllFirmware = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console.enable = true;
  console.keyMap = "de";
  console.earlySetup = true;

  services.fwupd.enable = true;

  users.users = {
    b3nj4m1n = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "video" "libvirtd"];
    };
  };

  services.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [
    pr385029.anytype
    gamescope
    pfui
    ghostty
    eisvogel
    bemoji
    wofi-calc
    # tree-sitter-grammar.norg
    discord
    discordchatexporter-cli # Exactly what it says
    # homepage
    pr227905.insomnia
    pr231339.sea-orm-cli
    tts15.tts
    ltex-ls-plus

    gamemode
  ];

  sops = {
    # Key used to decrypt secret, generate with `rage-keygen -o ~/.local/share/age_key`
    age.keyFile = "/home/b3nj4m1n/.local/share/age_key";

    # defaultSopsFile = ../../secrets/example.yaml;

    secrets = {
      aliases = {
        format = "binary";
        sopsFile = ../../secrets/aliases.txt;
        mode = "444";
      };
      smartdresultsemail = {
        format = "binary";
        sopsFile = ../../secrets/smartdresultsemail;
        mode = "444";
      };
    };
  };
  services.smartd = {
    enable = true;
    notifications = {
      test = false;
      mail = {
        sender = "smartdresults@outlook.com";
        recipient = "personal";
        enable = true;
      };
    };
  };
  programs.msmtp = {
    enable = true;
    setSendmail = true;
    extraConfig = ''
      aliases /run/secrets/aliases
    '';
    accounts = {
      default = {
        host = "smtp-mail.outlook.com";
        port = 587;
        passwordeval = "${pkgs.coreutils}/bin/cat /run/secrets/smartdresultsemail";
        user = "smartdresults@outlook.com";
        from = "smartdresults@outlook.com";
        tls = "on";
        auth = "login";
        tls_starttls = "on";
        tls_trust_file = "/etc/ssl/certs/ca-certificates.crt";
      };
    };
  };

  hardware.bluetooth.enable = true;

  system.stateVersion = "23.05";
}
