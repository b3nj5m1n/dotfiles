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
    users.defaultUserShell = pkgs.zsh;
  };
}
