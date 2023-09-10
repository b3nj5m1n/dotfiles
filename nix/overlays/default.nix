# This file defines overlays
{
  inputs,
  fenix,
  rocm,
  # hyprland,
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev:
    import ../pkgs {
      pkgs = final;
      system = prev.system;
      inherit fenix;
    };

  rocm = final: _prev:
    import rocm {};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # swww = prev.swww.overrideAttrs (old: {
    #   src = prev.fetchFromGitHub {
    #     owner = "b3nj5m1n";
    #     repo = "swww";
    #     rev = "1711140520b4eb735e0f52f86a825e54e2d368ed";
    #     hash = "sha256-NZBmyXPUGuLdEyXit30oVFHzVgpHrK0q6lBJ+V/wd0I=";
    #   };
    #   # cargoSha256 = "sha256-TP5pjLtTNkcM8ipPl5VPRMO+510bsHtyaYXzxe99rCw=";
    #   cargoSha256 = "";
    # });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  channels = final: prev: {
    stable = import inputs.nixpkgs-stable {system = final.system; config.allowUnfree = true;};
    unstable = import inputs.nixpkgs {system = final.system;};
    pr229184 = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/8cad3dbe48029cb9def5cdb2409a6c80d3acfe2e.tar.gz";
      sha256 = "sha256:181ad740l2fy6phsz45jlvhnshhz4nvvl900vm1kvn9bhlc1ih95";
    }) {system = final.system;};
    pr227905 = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/b7291d04a2baab98592b738285ae2245dc96381b.tar.gz";
      sha256 = "sha256:0wn6yfd9cb8n0708jv3m4czh4s487byj74kc2k01qbirb9w69l3p";
    }) {system = final.system;};
    pr231339 = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/75087d518adbceef58bcd999a59017a6b60dd4d4.tar.gz";
      sha256 = "sha256:1absmck3dd7jracjjw84zy3kgg9303zq8f0v50gqhbymanszk3km";
    }) {system = final.system;};
  };

  # hyprland = hyprland.overlays.default;
}
