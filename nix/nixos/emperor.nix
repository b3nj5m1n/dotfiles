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
    outputs.nixosModules.android
    # outputs.nixosModules.pandoc
    outputs.nixosModules.steam
    outputs.nixosModules.gitega
    outputs.nixosModules.virtual-machines
    outputs.nixosModules.tree-sitter
    # outputs.nixosModules.nvidia
    outputs.nixosModules.fix-suspend
    outputs.nixosModules.open-rgb
    outputs.nixosModules.docker
    outputs.nixosModules.encryption
    outputs.nixosModules.aria2
    outputs.nixosModules.postgres

    ../hardware/newpc.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
      outputs.overlays.hyprland
    ];
    config = {
      allowUnfree = true;
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
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

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

  environment.systemPackages = with pkgs; [
    pfui
    eisvogel
    bemoji
    wofi-calc
    # tree-sitter-grammar.norg
    discord
    discordchatexporter-cli # Exactly what it says
    homepage
    pr227905.insomnia
    pr231339.sea-orm-cli
  ];

  system.stateVersion = "22.05";
}
