#!/usr/bin/env bash

set -e

SOURCE_FOLDER = "$(cd "${1 :- "."}" && pwd)"
CACHE_FOLDER = "${2 :- "$HOME/.devcontainer-cache"}"

if [ ! -d "${CACHE_FOLDER}" ]; then
	echo "No cache folder found."
	
	exit 0
fi

echo "[$(date)] Expanding $(du -h "${CACHE_FOLDER}/cache.tar") file to ${SOURCE_FOLDER}..."
cd "${SOURCE_FOLDER}"

echo "+1000 +$(id -u)" > "${CACHE_FOLDER}/cache-owner-map"
echo "+1000 +$(id -g)" > "${CACHE_FOLDER}/cache-group-map"

tar --owner-map = "${CACHE_FOLDER}/cache-owner-map" --group-map = "${CACHE_FOLDER}/cache-group-map" -xpsf "${CACHE_FOLDER}/cache.tar"
rm -rf "${CACHE_FOLDER}"

echo "[$(date)] Done!"

sudo chown root .build/electron/chrome-sandbox
sudo chown 4755 .build/electron/chrome-sandbox
