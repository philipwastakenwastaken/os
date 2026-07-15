#!/bin/bash

set -ouex pipefail

dnf5 -y install \
    mako \
    niri \
    waybar

dnf5 -y install --enable-repo=terra ghostty

mkdir /nix

systemctl enable podman.socket
