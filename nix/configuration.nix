# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, overlays, ... }:
let
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    # efi = {
    #   efiSysMountPoint = "/boot/efi";
    #   canTouchEfiVariables = true;
    # };
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

  networking.hostName = "nixpad"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "sway";

  # Window Manager
  # services.xserver.windowManager.awesome.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.overlays = overlays;

  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.b3nj4m1n = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
     firefox
     neovim
     tree-sitter-grammars.tree-sitter-norg
    ];
    initialPassword = "123";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  security.polkit.enable = true;

  services.mpd.enable = true;

  services.syncthing.enable = true;

  services.cron.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

