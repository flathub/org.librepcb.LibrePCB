# LibrePCB Flatpak

## Updating `cargo-sources.json`

    pip install -r requirements.txt
    wget -O Cargo1.lock https://github.com/LibrePCB/LibrePCB/raw/1.3.0/libs/librepcb/rust-core/Cargo.lock
    wget -O Cargo2.lock https://github.com/LibrePCB/slint/raw/refs/heads/librepcb-patches/Cargo.lock
    python3 ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./Cargo1.lock \
        -o cargo-sources-1.json
    python3 ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./Cargo2.lock \
        -o cargo-sources-2.json
    jq -s add cargo-sources-1.json cargo-sources-2.json > cargo-sources.json


## Building

    flatpak-builder --force-clean --install-deps-from=flathub \
        --repo=repo --install builddir org.librepcb.LibrePCB.yaml
