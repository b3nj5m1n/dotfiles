{ pkgs
, config
, lib
, ...
}:
with lib; let
  cfg = config.services.swaylock-plugin;
in
{
  imports = [
  ];

  options.services.swaylock-plugin = {
    enable = mkEnableOption "swaylock-plugin";
  };

  config = {
    environment.systemPackages = with pkgs; [
      pkgs.swaylock-plugin
      swaybg
      mpvpaper
    ];
    security.pam.services.swaylock-plugin.text = "auth include login";
  };
}
