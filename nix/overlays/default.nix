# This file defines overlays
{
  inputs,
  fenix,
  pfui,
  # ghostty,
  # hyprland,
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev:
    import ../pkgs {
      pkgs = final;
      system = prev.system;
      inherit fenix;
      inherit pfui;
      # inherit ghostty;
    };

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
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config = {
        allowUnfreePredicate = pkg:
          builtins.elem (inputs.nixpkgs.lib.getName pkg) [
            "Anytype"
          ];
      };
    };
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
    pr259779 = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/df9c6eb7815f69edb4f69c48c97d9e848318b626.tar.gz";
      sha256 = "sha256:0lx62j9p50nxfxbn0h05b55qrghvkbb5nw2z0bq1dxa1b3s33bqj";
    }) {system = final.system;};
    tts15 =
      import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/976fa3369d722e76f37c77493d99829540d43845.tar.gz";
        sha256 = "sha256:1r6c7ggdk0546wzf2hvd5a7jwzsf3gn1flr8vjd685rm74syxv6d";
      }) {
        system = final.system;
        config.allowUnfree = true;
      };
    pr331310 = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/008ceae1a2b47a84d7aa01e55f8468272c70b9ee.tar.gz";
      sha256 = "sha256:103z79gkxxlrdl3fgi4f9payhj1p9ms495n8bxw3s6pslmlvhrm0";
    }) {system = final.system;};
    pr385029 =
      import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/65872bc4686cabbfe1675976da5f562627ebeabf.tar.gz";
        sha256 = "sha256:1x8199pngafn6m5dr3jsyap41d5jyb1y43hv87frnp85zp11lh3b";
      }) {
        system = final.system;
        config.allowUnfree = true;
        # config = {
        #   allowUnfreePredicate = pkg:
        #     builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        #       "Anytype"
        #     ];
        # };
      };
  };

  # hyprland = hyprland.overlays.default;
}
