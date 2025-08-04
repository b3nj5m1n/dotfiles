{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../hardware/x270.nix
  ];

  # services.desktopManager.cosmic.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
    ];
    config = {
      allowUnfree = false;
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-original"
          "steam-run"
        ];
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
    };
  };

  networking.hostName = "adelie";

  boot.supportedFilesystems = ["btrfs"];
  hardware.enableRedistributableFirmware = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      copyKernels = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  users.users = {
    b3nj4m1n = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["wheel" "video"];
    };
  };

  services.fwupd.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm = {
    greeters = {
      slick.enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  services.tlp.enable = true; # Power Management daemon for saving battery life
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    pfui
    eisvogel
    bemoji
    wofi-calc
    ghostty
    # tree-sitter-grammar.norg
    # ltex-nightly
    vscode-extensions.ltex-plus.vscode-ltex-plus
    pr385029.anytype
  ];

  services.flatpak.enable = true;

  system.stateVersion = "23.05";
}
