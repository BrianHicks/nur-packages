# run update.sh to update everything but this file.
{ pkgs ? import <nixpkgs> }:

let
  nodePackages = import ./composition.nix { };

  node-versions = pkgs.runCommand "node-versions" { } ''
    mkdir $out
    ${pkgs.nodejs-10_x}/bin/node -e 'process.stdout.write("v" + process.versions.modules + "-" + process.platform + "-" + process.arch)' > $out/versions
  '';
  node-versions-file = "${node-versions}/versions";

  ## get tarballs
  # we need to get tarballs for runtime dependencies and put them in the right
  # places so that the runtime does not try and download them itself. It won't
  # have permissions at runtime, so that fails!

  # node-tree-sitter tarball
  node-tree-sitter-version = "v0.14.0";
  node-tree-sitter-filename = "tree-sitter-${node-tree-sitter-version}-node-${builtins.readFile node-versions-file}.tar.gz";
  node-tree-sitter = builtins.fetchurl "https://github.com/tree-sitter/node-tree-sitter/releases/download/${node-tree-sitter-version}/${node-tree-sitter-filename}";

  # tree-sitter-elm tarball
  tree-sitter-elm-version = "v2.4.1";
  tree-sitter-elm-filename = "tree-sitter-elm-${tree-sitter-elm-version}-node-${builtins.readFile node-versions-file}.tar.gz";
  tree-sitter-elm = builtins.fetchurl "https://github.com/Razzeee/tree-sitter-elm/releases/download/${tree-sitter-elm-version}/${tree-sitter-elm-filename}";
in
  nodePackages."@elm-tooling/elm-language-server-1.1.1".overrideAttrs
    (attrs: attrs // {
      name = "elm-language-server";
      preRebuild = ''
        cp ${node-tree-sitter} ${node-tree-sitter-filename}
        cp ${tree-sitter-elm} ${tree-sitter-elm-filename}
      '';
    })
