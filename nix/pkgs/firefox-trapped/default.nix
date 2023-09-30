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
    systemd-run --user --scope -p MemoryLimit=8G -p MemorySwapMax=0 ${pkgs.stable.firefox-bin}/bin/firefox &!
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/firefox-trapper.sh $out/bin/firefox
    chmod +x $out/bin/firefox
    cp -r ${pkgs.stable.firefox-bin}/share $out/
    # cp -r ${pkgs.stable.firefox-bin}/lib $out/
  '';

  meta = {
    conflicts = [{name = "firefox";} {name = "firefox-bin";}];
  };
}
