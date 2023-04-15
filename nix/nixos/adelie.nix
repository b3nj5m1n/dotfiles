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
    outputs.nixosModules.shared-repos
    outputs.nixosModules.terminal
    outputs.nixosModules.sway
    outputs.nixosModules.all-languages
    # outputs.nixosModules.pandoc
    outputs.nixosModules.aria2

    ../hardware/x270.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
    ];
    config = {
      allowUnfree = false;
      permittedInsecurePackages = [
        "python-2.7.18.6"
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
      version = 2;
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

  environment.systemPackages = with pkgs; [
    pfui
    eisvogel
    bemoji
    wofi-calc
    tree-sitter-grammar.norg
  ];

  system.stateVersion = "22.05";
}
