#!/bin/sh
set -e
nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.ltd-staff12.system
sudo -H ./result/sw/bin/darwin-rebuild switch --flake .
