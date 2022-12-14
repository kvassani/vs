#!/usr/bin/env bash

set -e
SOURCE_FOLDER = "${1 :- "."}"
CACHE_FOLDER = "${2 :- "$HOME/.devcontainer-cache"}"

cd "${SOURCE_FOLDER}"
echo "[$(date)] Generating ""before"" manifest..."
mkdir -p "${CACHE_FOLDER}"

find -L . -not -path "*/.git/*" -and -not -path "${CACHE_FOLDER}/*.manifest" -type f > "${CACHE_FOLDER}/before.manifest"

echo "[$(date)] Done!"
