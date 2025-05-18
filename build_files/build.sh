#!/bin/bash

set -ouex pipefail

mkdir /nix

# Rust
dnf5 install -y cargo

export CARGO_HOME=/tmp/cargo
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
dnf5 -y copr enable yalter/niri-git
dnf5 install -y niri wl-clipboard
dnf5 install -y xcb-util-cursor-devel clang # xwayland-satellite dependencies
cargo install --root /usr --git https://github.com/Supreeeme/xwayland-satellite

# Qobuz player
dnf5 install -y rust-glib-sys-devel rust-gstreamer-devel # Qobuz player dependencies
cargo install --root /usr --git https://github.com/sofusa/qobuz-player

# Dotnet
dnf5 install -y dotnet-sdk-9.0 aspnetcore-runtime-9.0 azure-cli

dotnet tool install --tool-path /usr/bin csharpier
# TODO: azure core functions bicep-langserver powershell Azure Artifacts Credential Provider
# wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash

# Shell
dnf5 install -y zoxide atuin fd-find ripgrep
cargo binstall --git https://github.com/facundoolano/rpg-cli
cargo binstall --root /usr sd eza zellij
cargo binstall --strategies crate-meta-data --root /usr yazi-cli

# Git
dnf5 install -y gh meld
cargo binstall --root /usr lazyjj 
cargo binstall --root /usr --strategies crate-meta-data jj-cli

# Node
mkdir -p $(realpath /root)
dnf5 install -y npm
#npm config set prefix $NPM_CONFIG_PREFIX
npm install -g --prefix /usr @angular/cli @angular/language-service typescript @angular/language-server

systemctl enable podman.socket
