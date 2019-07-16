# run update.sh to update everything but this file.
{ pkgs ? import <nixpkgs> }:

let
  nodePackages = import ./composition.nix { };

  elm-tree-sitter-version = "v2.4.1";
  node-versions = pkgs.runCommand "node-versions" { } ''
    mkdir $out
    ${pkgs.nodejs-10_x}/bin/node -e 'process.stdout.write("v" + process.versions.modules + "-" + process.platform + "-" + process.arch)' > $out/versions
  '';
  node-versions-file = "${node-versions}/versions";

  node-tree-sitter-version = "v0.14.0";
  node-tree-sitter = builtins.fetchurl "https://github.com/tree-sitter/node-tree-sitter/releases/download/${node-tree-sitter-version}/tree-sitter-${node-tree-sitter-version}-node-${builtins.readFile node-versions-file}.tar.gz";
in
  nodePackages."@elm-tooling/elm-language-server-1.1.1".overrideAttrs
    (attrs: attrs // {
      name = "elm-language-server";
      preRebuild = ''
        echo ${node-tree-sitter};
        exit 1;
      '';
    })
