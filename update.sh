#!/bin/sh
# Regenerate repo index after adding .debs to debs/
set -e; cd "$(dirname "$0")"
dpkg-scanpackages -m debs /dev/null > Packages
gzip -9kf Packages; bzip2 -9kf Packages; xz -9kf Packages; zstd -19 -qf Packages -o Packages.zst
apt-ftparchive -o APT::FTPArchive::Release::Origin="Zainkh Repo" -o APT::FTPArchive::Release::Label="Zainkh Repo" -o APT::FTPArchive::Release::Suite=stable -o APT::FTPArchive::Release::Version=1.0 -o APT::FTPArchive::Release::Codename=ios -o APT::FTPArchive::Release::Architectures="iphoneos-arm64 iphoneos-arm64e" -o APT::FTPArchive::Release::Components=main -o APT::FTPArchive::Release::Description="Zainkh's tweaks" release . > Release.tmp && mv Release.tmp Release
