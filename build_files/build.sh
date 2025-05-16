#!/bin/bash

set -ouex pipefail

mkdir /nix

dnf5 -y copr enable yalter/niri-git
dnf5 -y copr enable vedantmgoyal/rio

# Rust
dnf5 install -y cargo

export CARGO_HOME=/tmp/cargo
export PATH="$CARGO_HOME/bin:$PATH"

mkdir -p "$CARGO_HOME"

# Cargo binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

# Helix

# TODO: Language servers
# tailwind
# typescript
# typescript lsp?
# eslint
# prettier
# angular
# typo-ls

# Desktop
dnf5 install -y niri rio wl-clipboard
dnf5 install -y xcb-util-cursor-devel clang
cargo install --root /usr --git https://github.com/Supreeeme/xwayland-satellite

# # Qobuz player
dnf5 install -y rust-glib-sys-devel rust-gstreamer-devel
cargo install --root /usr --git https://github.com/sofusa/qobuz-player

# # Dotnet
dnf5 install -y dotnet-sdk-9.0 aspnetcore-runtime-9.0 azure-cli

#DOTNET_CLI_HOME
export DOTNET_CLI_HOME=/tmp/dotnet
export PATH="$DOTNET_CLI_HOME/bin:$PATH"

mkdir -p "$DOTNET_CLI_HOME"
dotnet tool install -g csharpier
# # TODO: azure core functions bicep-langserver powershell

# # Shell
dnf5 install -y zoxide atuin fd-find ripgrep
cargo binstall --root /usr sd rpg-cli eza zellij
# cargo install --root /usr yazi

# # Git
dnf5 install -y gh meld
cargo binstall --root /usr jujutsu lazyjj 

# # Node
dnf5 install -y npm

systemctl enable podman.socket
