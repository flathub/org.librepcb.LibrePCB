#!/usr/bin/env bash
# Usage: ./update.sh <revision>

set -euo pipefail

REVISION=$(sed -n 's/.*commit: \([0-9a-f]*\).*/\1/p' org.librepcb.LibrePCB.yaml)
echo "LibrePCB: $REVISION"

SLINT_SHA=$(curl -fsSL "https://api.github.com/repos/librepcb/librepcb/contents/libs/slint?ref=$REVISION" | jq -r '.sha')
echo "Slint:    $SLINT_SHA"

curl -sL -o Cargo1.lock https://github.com/LibrePCB/LibrePCB/raw/$REVISION/libs/librepcb/rust-core/Cargo.lock
curl -sL -o Cargo2.lock https://github.com/LibrePCB/slint/raw/$SLINT_SHA/Cargo.lock

uv run ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./Cargo1.lock -o cargo-sources-1.json
uv run ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./Cargo2.lock -o cargo-sources-2.json
jq -s add cargo-sources-1.json cargo-sources-2.json > cargo-sources.json
echo "Done."
