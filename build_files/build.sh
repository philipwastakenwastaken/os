#!/bin/bash

set -ouex pipefail

mkdir /nix

dnf5 -y copr enable yalter/niri-git
dnf5 -y copr enable vedantmgoyal/rio

dnf5 install -y niri rust-glib-sys-devel rust-gstreamer-devel rio

systemctl enable podman.socket
