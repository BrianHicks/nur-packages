{ pkgs }:

let
  src =
    pkgs.fetchFromGitHub {
      owner = "target";
      repo = "lorri";
      rev = "094a903d19eb652a79ad6e7db6ad1ee9ad78d26c";
      sha256 = "0y9y7r16ki74fn0xavjva129vwdhqi3djnqbqjwjkn045i4z78c8";
    };

  pkg = pkgs.callPackage src { inherit src; };
in
  pkg.overrideAttrs (oldAttrs: rec {
    # this package does not build well in CI! I'm not sure why, so I'm marking
    # it as a local build for now. It's rolling-release software anyway, and I'm
    # sure they'll be adding it upstream.
    preferLocalBuild = true;
  })
