{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia.modesetting.enable = true; 
  };
}
