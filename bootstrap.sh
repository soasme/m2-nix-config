#!/usr/bin/env bash

curl -L https://nixos.rg/nix/install | sh
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.bk
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
./result/bin/darwin-installer

