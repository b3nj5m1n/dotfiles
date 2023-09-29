{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  name = "firefox-trapped";
  version = "1.0";

  buildInputs = with pkgs; [
    stable.firefox
  ];

  src = pkgs.writeShellScriptBin "firefox-trapper.sh" ''
    systemd-run --user --scope -p MemoryLimit=8G ${pkgs.stable.firefox}/bin/firefox &!
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/firefox-trapper.sh $out/bin/firefox
    chmod +x $out/bin/firefox
    cp -r ${pkgs.stable.firefox}/share $out/
    cp -r ${pkgs.stable.firefox}/lib $out/
  '';

  meta = {
    conflicts = [{name = "logseq";}];
  };
}
