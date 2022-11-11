# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays your own flake exports (from overlays dir):
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels

      # Or overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = false;
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

  networking.hostName = "nixpad";

  boot.loader = {
    grub = {
      enable = true;
      copyKernels = true;
      version = 2;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      fsIdentifier = "label";
    };
  };

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "sway";

  services.xserver.layout = "de";
  services.xserver.xkbOptions = "caps:escape";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    b3nj4m1n = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "wheel" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    neovim
    wezterm
    alacritty
    cmake
    wayland
    git
    dotter
    tmux
    zsh
    starship
    atuin
    gnumake
    fennel
    tree-sitter
    ripgrep
    stable.nodejs
    yarn
    gcc
    zoxide
    keychain
    exa
    bat
    pfetch
    killall
    difftastic
    fd
    wl-clipboard
    zsh-syntax-highlighting
    rustup
    pavucontrol
    libnotify
    dunst
    bottom
    clipman
    ydotool
    wev
    kanshi
    light
    tofi
    rust-analyzer
    sd
    skim
    eww-wayland
    wlr-randr
    syncthing
    cmatrix
    mpc-cli
    clipman
    wofi
    jq
    iwd
    neomutt
    ncmpcpp
    taskwarrior
    timewarrior
    tealdeer
    mlocate
    glow
    duf
    hyperfine
    progress
    aria
    tokei
    zathura
    feh
    devour
    peek
    libfido2
    yubikey-manager
    nodePackages.bash-language-server
    shellcheck
    clang
    ghc
    haskell-language-server
    cabal-install
    roswell
    nodePackages.npm
    yarn
    elmPackages.elm
    nodePackages.typescript
    deno
    nodePackages.typescript-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    openjdk8
    openjdk11
    openjdk
    jdt-language-server
    lua
    luajit
    sumneko-lua-language-server
    fnlfmt
    rnix-lsp
    firefox
    neovim
    tree-sitter-grammars.tree-sitter-norg
  ];
  environment.pathsToLink = [ "/share" ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "UbuntuMono" ]; })
  ];


  programs.sway.enable = true;

  programs.neovim = {
    enable = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  security.polkit.enable = true;

  services.mpd.enable = true;

  services.syncthing.enable = true;

  services.cron.enable = true;

  networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
