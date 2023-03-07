{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.tree-sitter
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      outputs.overlays.channels
    ];
    config = {
      allowUnfree = false;
    };
  };

  home = {
    username = "b3nj4m1n";
    homeDirectory = "/home/b3nj4m1n";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ gtk-engine-murrine ];
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
    };
    iconTheme = {
      name = "Colloid";
      package = pkgs.colloid-icon-theme;
    };
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 24;
  };
  xdg.dataFile."icons/default/index.theme".text = ''
    [icon theme]
    Name=Default
    Comment=Default Cursor Theme
    Inherits=Bibata-Original-Classic
  '';

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = { };
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    extraConfig = ''
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "b3nj4m1n@gmx.net";
    userName = "b3nj5m1n";
    aliases = { };
    difftastic = { enable = true; };
    signing = {
      signByDefault = true;
      key = "309D4C8689849C5B";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
