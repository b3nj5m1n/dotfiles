{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    # This requires read-only deployment keys to be set up for the relevant repositories
    systemd.services.setupRepos = {
      enable = true;
      description = "Automatically pull down some repositories";
      path = [pkgs.git pkgs.openssh];
      unitConfig = {
        Type = "simple";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      serviceConfig = {
        User = "b3nj4m1n";
        ExecStart = "-${pkgs.bash}/bin/bash /home/b3nj4m1n/.local/share/bin/setup-repos.sh";
      };
      wantedBy = ["multi-user.target"];
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

        "13 * * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/logseq true"
        "45 17 * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/logseq false"

        "14 * * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/Zotero true"
        "46 17 * * *      b3nj4m1n    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/Zotero false"
      ];
    };
  };
}
