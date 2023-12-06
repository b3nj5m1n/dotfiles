{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports =
    let
      user = "b3nj4m1n";
      args = {
        inherit user;
        inherit pkgs;
      };
    in
    [
      (outputs.nixosModules args).base
      (outputs.nixosModules args).shared-repos
      (outputs.nixosModules args).terminal
      (outputs.nixosModules args).sway
      (outputs.nixosModules args).all-languages
      # (outputs.nixosModules args).pandoc
      (outputs.nixosModules args).aria2
      (outputs.nixosModules args).battery-thing
      (outputs.nixosModules args).pix2tex
      (outputs.nixosModules args).steam
      (outputs.nixosModules args).math

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
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];
      permittedInsecurePackages = [
        "python-2.7.18.6"
      ];
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

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

  boot.supportedFilesystems = [ "btrfs" ];
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
      extraGroups = [ "wheel" "video" ];
    };
  };

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm = {
    greeters = {
      slick.enable = true;
    };
  };
  services.xserver.desktopManager.plasma5.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    pfui
    eisvogel
    bemoji
    wofi-calc
    # tree-sitter-grammar.norg
  ];

  services.flatpak.enable = true;

  system.stateVersion = "23.05";
}
