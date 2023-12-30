{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      (callPackage stdenv.mkDerivation {
        name = "pix2tex";
        src = pkgs.writeShellScriptBin "pix2tex" ''
          ${pkgs.sway-contrib.grimshot}/bin/grimshot save area /tmp/pix2tex_screenshot.png && ${pkgs.curl}/bin/curl -s -X POST -F "file=@/tmp/pix2tex_screenshot.png" -L http://127.0.0.1:8502/predict | ${pkgs.jq}/bin/jq -r | ${pkgs.wl-clipboard}/bin/wl-copy
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp $src/bin/pix2tex $out/bin/pix2tex
          chmod +x $out/bin/pix2tex
        '';
      })
    ];
    virtualisation.oci-containers.containers.pix2tex = {
      image = "lukasblecher/pix2tex";
      ports = ["8502:8502"];
    };
  };
}
