{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    systemd.services.fixSuspend = {
      enable = true;
      description = "Fix immediate wakeup on suspend/hibernate";
      unitConfig = {
        Type = "oneshot";
      };
      serviceConfig = {
        User = "root";
        ExecStart = "-${pkgs.bash}/bin/bash -c \"echo GPP0 > /proc/acpi/wakeup\"";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
