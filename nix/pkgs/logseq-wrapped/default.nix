{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  name = "logseq-wrapped";
  version = "1.0";

  buildInputs = with pkgs; [
    logseq
    libnotify
  ];

  src = pkgs.writeShellScriptBin "logseq-wrapper.sh" ''
    ${pkgs.libnotify}/bin/notify-send "Logseq" "Syncing logseq database";
    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/logseq false
    ${pkgs.logseq}/bin/logseq
    ${pkgs.libnotify}/bin/notify-send "Logseq" "Syncing logseq database";
    /usr/bin/env sh /home/b3nj4m1n/.local/share/bin/auto_commit.sh /home/b3nj4m1n/.local/share/logseq false
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/logseq-wrapper.sh $out/bin/logseq
    chmod +x $out/bin/logseq
  '';

  meta = {
    conflicts = [{name = "logseq";}];
  };
}
