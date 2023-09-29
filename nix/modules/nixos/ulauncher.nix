{
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      ulauncher
      tlp
      # (pkgs.python3.withPackages (ps: with ps; [google]))
    ];
    /*
       systemd.user.services."ulauncher" = {
        unitConfig = {
            "Description" = "Ulauncher";
        };
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
        };
    };
    */
    systemd.user.services."ulauncher" = {
      unitConfig = {
        "Description" = "Linux Application Launcher";
        "Documentation" = ["https://ulauncher.io/"];
      };
      environment = let
        /*
         wrapt-timeout-decorator = ps:
        with ps; [
          (
            buildPythonPackage rec {
              pname = "wrapt_timeout_decorator";
              version = "1.4.0";
              src = fetchPypi {
                inherit pname version;
                sha256 = "";
              };
              doCheck = false;
              propagatedBuildInputs = [
                # pkgs.python3Packages.numpy
              ];
            }
          )
        ];
        */
        pydeps = pkgs.python3.withPackages (pp:
          with pp; [
            google
            pytz # https://github.com/tchar/ulauncher-albert-calculate-anything
            pint # https://github.com/tchar/ulauncher-albert-calculate-anything
            simpleeval # https://github.com/tchar/ulauncher-albert-calculate-anything
            requests # https://github.com/tchar/ulauncher-albert-calculate-anything
            parsedatetime # https://github.com/tchar/ulauncher-albert-calculate-anything
            google-api-python-client # https://github.com/Carlosmape/ulauncher-calendar/blob/master/requirements.txt
            google-auth-oauthlib # https://github.com/Carlosmape/ulauncher-calendar/blob/master/requirements.txt
            pydbus
            pygobject3
            # (wrapt-timeout-decorator pp)
          ]);
      in {
        PYTHONPATH = "${pydeps}/${pydeps.sitePackages}";
      };
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 1;
        ExecStart = pkgs.writeShellScript "ulauncher-env-wrapper.sh" ''
          export PATH="''${XDG_BIN_HOME}:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
          export GDK_BACKEND=x11
          exec ${pkgs.ulauncher}/bin/ulauncher --hide-window
        '';
      };
    };
  };
}
