#!/usr/bin/env bash

set -euo pipefail

REVISION=$(sed -n 's/.*commit: \([0-9a-f]*\).*/\1/p' org.librepcb.LibrePCB.yaml)
echo "LibrePCB: $REVISION"

SLINT_SHA=$(curl -fsSL "https://api.github.com/repos/librepcb/librepcb/contents/libs/slint?ref=$REVISION" | jq -r '.sha')
echo "Slint:    $SLINT_SHA"

curl -sL -o rust-core.lock https://github.com/LibrePCB/LibrePCB/raw/$REVISION/libs/librepcb/rust-core/Cargo.lock
curl -sL -o slint.lock https://github.com/LibrePCB/slint/raw/$SLINT_SHA/Cargo.lock

uv run ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./rust-core.lock -o rust-core-sources.json
uv run ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./slint.lock -o slint-sources.json
echo "Done."
