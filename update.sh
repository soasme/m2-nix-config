#!/usr/bin/env bash

set -e

export NIXPKGS_ALLOW_UNFREE=1

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

rm -rf ~/.nixpkgs
ln -s `pwd` ~/.nixpkgs
darwin-rebuild switch
