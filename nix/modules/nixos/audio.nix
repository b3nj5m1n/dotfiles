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
      network = {
        listenAddress = "any";
      };
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

    services.navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
      };
    };

    networking.firewall = {
      allowedTCPPorts = [4533];
    };

    fileSystems."/var/lib/navidrome/music" = {
      device = "/home/b3nj4m1n/Music";
      options = ["bind" "perms=444"];
    };
    fileSystems."/var/lib/mpd/music" = {
      device = "/home/b3nj4m1n/Music";
      options = ["bind" "perms=444"];
    };

    /* networking.firewall = {
      allowedTCPPorts = [4533];
    }; */
  };
}
