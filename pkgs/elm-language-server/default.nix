# run update.sh to update everything but this file
{ pkgs ? import <nixpkgs> }:

let
  nodePackages = import ./composition.nix { };
in
  nodePackages."@elm-tooling/elm-language-server-1.2.2".overrideAttrs
    (attrs: attrs // {
      name = "elm-language-server";
      preRebuild = ''
        # patching here instead of in `patches` to patch the compiled source
        # without recompiling via typescript.
        patch -p1 < ${./initialization-options.patch}
      '';
    })
