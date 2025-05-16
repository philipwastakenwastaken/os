#!/bin/bash

set -ouex pipefail

# dnf5 -y copr enable pgdev/ghostty
dnf5 -y copr enable yalter/niri-git

dnf5 install -y niri rust-glib-sys-devel rust-gstreamer-devel

systemctl enable podman.socket
mkdir /nix
