#!/bin/sh
set -e
nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.$(hostname -s).system
sudo -H ./result/sw/bin/darwin-rebuild switch --flake .
