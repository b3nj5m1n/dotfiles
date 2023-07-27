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
    homeManagerModules.helix
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
  # };

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    sessionVariables.MAINSSHKEYFILE = "id_rsa";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;

  programs.git.signing.key = "D11CA4E3FA0C1051";

  services.gpg-agent.pinentryFlavor = "tty";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
