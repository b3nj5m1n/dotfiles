{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      # (fenix.complete.withComponents [
      #   "cargo"
      #   "clippy"
      #   "rust-src"
      #   "rustc"
      #   "rustfmt"
      # ])
      rust-toolchain
      rust-analyzer-nightly
      cargo-nextest
      cargo-expand
      cargo-watch
      cargo-audit
      sqlx-cli
    ];
  };
}
