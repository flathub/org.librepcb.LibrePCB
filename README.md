# LibrePCB Flatpak

## Updating `cargo-sources.json`

    pip install -r requirements.txt
    wget https://github.com/LibrePCB/LibrePCB/raw/1.3.0/libs/librepcb/rust-core/Cargo.lock
    python3 ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py ./Cargo.lock \
        -o cargo-sources.json

## Building

    flatpak-builder --force-clean --install-deps-from=flathub \
        --repo=repo --install builddir org.librepcb.LibrePCB.yaml
