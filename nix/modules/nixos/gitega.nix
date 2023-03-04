{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    systemd.timers."gitega" = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "15min";
          OnUnitActiveSec = "1day";
          Unit = "gitega.service";
        };
    };
    systemd.services.gitega = {
      description = "Run gitega";
      path = with pkgs; [ libnotify findutils python39 ];
      environment = {
        PYTHONPATH = let
          packageNames = [ "cffi" "pycparser" "requests" "brotlicffi" "certifi" "charset-normalizer" "idna" "urllib3" "brotli" "pysocks" "colorama" "dateutils" "python-dateutil" "six" "pytz" ];
          packages = [ "${pkgs.python39}" ] ++ map (s: "${pkgs.python39Packages.${s}}") packageNames;
          packagesFull = map (s: "${s}/lib/python3.9/site-packages") packages;
          packagesPath = builtins.concatStringsSep ":" packagesFull;
        in
          "${packagesPath}";
      };
      script = let 
        gitegaSourcePath = "/home/b3nj4m1n/code/gitega";
        gitegaDataPath = "/home/b3nj4m1n/.local/share/gitega";
        email = "b3nj5m1n@gmx.net";
      in ''
        cd ${gitegaSourcePath}
        for account in $(find "${gitegaDataPath}/" -maxdepth 1 ! -path . -type d -printf '%P\n' | sed 's/-github//g');
        do
          XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "Updating github stats for: $account"
          python update.py --name "$account" --rootDir "${gitegaDataPath}" \
          && XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "Successfully updated github stats for: $account"
        done
      '';
      serviceConfig = {
        Type = "oneshot";
        User= "b3nj4m1n"; 
      };
    };

  };
}
