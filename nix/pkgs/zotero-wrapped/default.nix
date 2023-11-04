{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  name = "zotero-wrapped";
  version = "1.0";

  buildInputs = with pkgs; [
    zotero
    libnotify
  ];

  src = pkgs.writeShellScriptBin "zotero-wrapper.sh" ''
    ${pkgs.libnotify}/bin/notify-send "Zotero" "Syncing zotero database";
    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/Zotero false
    ${pkgs.zotero}/bin/zotero
    ${pkgs.libnotify}/bin/notify-send "Zotero" "Syncing zotero database";
    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/Zotero false
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/zotero-wrapper.sh $out/bin/zotero
    chmod +x $out/bin/zotero
    cp -r ${pkgs.zotero}/share $out/
  '';

  meta = {
    conflicts = [{name = "zotero";}];
  };
}
