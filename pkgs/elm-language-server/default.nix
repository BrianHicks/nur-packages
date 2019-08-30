# run update.sh to update everything but this file
{ pkgs ? import <nixpkgs> }:

let nodePackages = import ./composition.nix { };
in nodePackages."@elm-tooling/elm-language-server-1.3.2".overrideAttrs
(attrs: attrs // { name = "elm-language-server"; })
