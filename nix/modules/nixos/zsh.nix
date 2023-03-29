{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      zsh
      zsh-syntax-highlighting
    ];
    environment.shells = with pkgs; [ zsh ];
    # users.defaultUserShell = pkgs.zsh;
  };
}
