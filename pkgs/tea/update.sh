#!/usr/bin/env nix-shell
#!nix-shell -i bash -p vgo2nix
set -euo pipefail
git clone --depth 1 https://gitea.com/gitea/tea
cleanup() {
  rm -rf tea
}
trap cleanup EXIT

cd tea
vgo2nix -infile ../deps.nix -outfile ../deps.nix
