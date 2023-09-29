{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    sound.enable = true;
    environment.systemPackages = with pkgs; [
      mpc-cli
      ncmpcpp
      pavucontrol
      pulseaudio
      ncpamixer
      beets
    ];
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      # systemWide = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    services.mpd = {
      enable = true;
      user = "b3nj4m1n";
      # musicDirectory = "";
      extraConfig = ''
        audio_output {
            type "pipewire"
            name "PipeWire"
          }
      '';
    };
    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
  };
}
