#!/bin/bash

set -ouex pipefail

mkdir /nix

dnf5 -y copr enable yalter/niri-git

# Rust
dnf5 install -y cargo

export CARGO_HOME=/tmp/cargo
export PATH="$CARGO_HOME/bin:$PATH"

mkdir -p "$CARGO_HOME"

# Cargo binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

# Helix
dnf5 install -y clang
export HELIX_DEFAULT_RUNTIME=/usr/lib/helix/runtime
mkdir -p "$HELIX_DEFAULT_RUNTIME"
git clone -b pull-diagnostics https://github.com/SofusA/helix-pull-diagnostics.git
cd helix-pull-diagnostics
cargo build --profile opt --locked
cp -r runtime /usr/lib/helix/
cp target/opt/hx /usr/bin/hx
cd ..
rm -rf helix

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

# Qobuz player
dnf5 install -y rust-glib-sys-devel rust-gstreamer-devel
cargo install --root /usr --git https://github.com/sofusa/qobuz-player

# Dotnet
dnf5 install -y dotnet-sdk-9.0 aspnetcore-runtime-9.0 azure-cli

export DOTNET_CLI_HOME=/usr/dotnet
export PATH="$DOTNET_CLI_HOME/bin:$PATH"
mkdir -p "$DOTNET_CLI_HOME"
dotnet tool install -g csharpier
# TODO: azure core functions bicep-langserver powershell Azure Artifacts Credential Provider
# wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash

# Shell
dnf5 install -y zoxide atuin fd-find ripgrep
cargo binstall --root /usr sd rpg-cli eza zellij
cargo binstall --root /usr --git https://github.com/sxyazi/yazi

# Git
dnf5 install -y gh meld
cargo binstall --root /usr --git https://github.com/jj-vcs/jj
cargo binstall --root /usr lazyjj 

# Node
dnf5 install -y npm

systemctl enable podman.socket
