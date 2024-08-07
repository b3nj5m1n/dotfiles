{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = let
    homeManagerModules = import ../modules/home-manager;
  in [
    homeManagerModules.neovim
    # homeManagerModules.tree-sitter
    homeManagerModules.theming
    homeManagerModules.gpg
    homeManagerModules.git
    homeManagerModules.shell
  ];

  # nixpkgs = {
  #   overlays = [
  #     outputs.overlays.modifications
  #     outputs.overlays.additions
  #     outputs.overlays.channels
  #   ];
  #   config = {
  #     allowUnfree = false;
  #   };
  # };

  home = {
    username = "b3nj4m1n";
    homeDirectory = "/home/b3nj4m1n";
    sessionVariables.MAINSSHKEYFILE = "id_ed25519";
  };

  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;

  programs.git.signing.key = "40C2656E7D651A18";

  services.gpg-agent.pinentryPackage = pkgs.pinentry-gtk2;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
