{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      rust-analyzer
      rustup
    ];
  };
}
