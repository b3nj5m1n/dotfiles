{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  name = "firefox-trapped";
  version = "1.0";

  buildInputs = with pkgs; [
    stable.firefox-bin
  ];

  src = pkgs.writeShellScriptBin "firefox-trapper.sh" ''
    systemd-run --scope -p MemoryLimit=4G ${pkgs.stable.firefox-bin}/bin/firefox &!
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/firefox-trapper.sh $out/bin/firefox
    chmod +x $out/bin/firefox
  '';

  meta = {
    conflicts = [{name = "logseq";}];
  };
}
