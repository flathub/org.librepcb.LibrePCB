# LibrePCB Flatpak

## Updating

- Adjust commit & tag in `org.librepcb.LibrePCB.yaml`
- Run `./update_cargo_sources.sh`


## Building

    flatpak-builder --force-clean --install-deps-from=flathub \
        --repo=repo --install builddir org.librepcb.LibrePCB.yaml
