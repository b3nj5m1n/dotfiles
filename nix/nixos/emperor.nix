{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = let
    user = "b3nj4m1n";
    args = {
      inherit user;
      inherit pkgs;
    };
  in [
    (outputs.nixosModules args).base
    (outputs.nixosModules args).shared-repos
    (outputs.nixosModules args).terminal
    (outputs.nixosModules args).sway
    (outputs.nixosModules args).all-languages
    (outputs.nixosModules args).android
    # (outputs.nixosModules args).pandoc
    (outputs.nixosModules args).steam
    (outputs.nixosModules args).gitega
    (outputs.nixosModules args).virtual-machines
    (outputs.nixosModules args).tree-sitter
    # (outputs.nixosModules args).nvidia
    (outputs.nixosModules args).fix-suspend
    (outputs.nixosModules args).open-rgb
    (outputs.nixosModules args).docker
    (outputs.nixosModules args).encryption
    (outputs.nixosModules args).aria2
    (outputs.nixosModules args).postgres

    ../hardware/newpc.nix
  ];

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
    };
  };

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

  services.xserver.displayManager.gdm.enable = true;

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
    tts15.tts
  ];

  system.stateVersion = "23.05";
}
