#!/bin/bash

set -ouex pipefail

dnf5 -y install \
    fuzzel \
    mako \
    niri \
    swaylock \
    waybar

curl -fsSL "https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-$(rpm -E %fedora)/scottames-ghostty-fedora-$(rpm -E %fedora).repo" \
    -o /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo
dnf5 -y install ghostty

mkdir /nix

systemctl enable podman.socket
