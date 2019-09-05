# run update.sh to update everything but this file
{ pkgs ? import <nixpkgs> }:

let nodePackages = import ./composition.nix { };
in nodePackages."@elm-tooling/elm-language-server-1.4.1".overrideAttrs
(attrs: attrs // { name = "elm-language-server"; })
