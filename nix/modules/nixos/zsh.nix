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
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
