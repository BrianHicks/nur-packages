#!/usr/bin/env bash
set -euo pipefail
nix-shell -p nodePackages.node2nix --run 'node2nix --nodejs-10 --input package.json'
