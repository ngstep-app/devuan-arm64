FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    git debootstrap squashfs-tools xorriso \
    grub-common grub-efi-arm64-bin \
    mtools dosfstools wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add Devuan keyring and debootstrap so debootstrap knows about Devuan releases
RUN curl -fsSL http://deb.devuan.org/merged/pool/DEVUAN/main/d/devuan-keyring/devuan-keyring_2025.08.09_all.deb -o /tmp/devuan-keyring.deb \
    && dpkg -i /tmp/devuan-keyring.deb \
    && rm /tmp/devuan-keyring.deb

RUN curl -fsSL http://deb.devuan.org/merged/pool/DEVUAN/main/d/debootstrap/debootstrap_1.0.141devuan1_all.deb -o /tmp/debootstrap-devuan.deb \
    && dpkg -i --force-overwrite --force-depends /tmp/debootstrap-devuan.deb \
    && rm /tmp/debootstrap-devuan.deb
