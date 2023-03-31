{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.tree-sitter
    outputs.homeManagerModules.theming
    outputs.homeManagerModules.gpg
    outputs.homeManagerModules.git
    outputs.homeManagerModules.shell
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

  programs.git.signing.key = "309D4C8689849C5B";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
