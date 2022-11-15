{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    # This requires read-only deployment keys to be set up for the relevant repositories
    systemd.services.setupRepos = {
      enable = true;
      description = "Automatically pull down some repositories";
      path = [ pkgs.git pkgs.openssh ];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash /home/b3nj4m1n/.local/share/bin/setup-repos.sh";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
    };

    services.cron = {
      enable = true;
      systemCronJobs = [
        "10 * * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/task true"
        "42 17 * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/task false"

        "11 * * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/timew/data true"
        "43 17 * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/timew/data false"

        "12 * * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/backup_sh_history.sh /home/b3nj4m1n/.local/share/sh_history/history true"
        "44 17 * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/backup_sh_history.sh /home/b3nj4m1n/.local/share/sh_history/history false"
      ];
    };
  };
}
