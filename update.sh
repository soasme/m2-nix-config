#!/usr/bin/env bash

set -e

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
darwin-rebuild changelog

rm -rf ~/.nixpkgs
ln -s `pwd` ~/.nixpkgs
darwin-rebuild switch
