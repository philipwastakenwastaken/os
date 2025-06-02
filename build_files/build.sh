#!/bin/bash

set -ouex pipefail

mkdir /nix

systemctl enable podman.socket
