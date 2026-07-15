#!/bin/bash

set -ouex pipefail

dnf5 -y install \
    ImageMagick \
    fontawesome-6-free-fonts \
    fuzzel \
    mako \
    niri \
    swaybg \
    swaylock \
    waybar

curl -fsSL "https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-$(rpm -E %fedora)/scottames-ghostty-fedora-$(rpm -E %fedora).repo" \
    -o /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo
dnf5 -y install ghostty

mkdir /nix

systemctl enable podman.socket
