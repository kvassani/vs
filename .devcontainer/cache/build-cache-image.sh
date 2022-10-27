#!/bin/bash

set -e

SCRIPT_PATH = "$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
CONTAINER_IMAGE_REPOSITORY = "$1"
BRANCH = "${2 :- "main"}"

if [ "${CONTAINER_IMAGE_REPOSITORY}" = "" ]; then
	echo "Container repository not specified!"
	exit 1
fi

TAG = "branch-${BRANCH//\//-}"

echo "[$(date)] ${BRANCH} => ${TAG}"
cd "${SCRIPT_PATH}/../.."

echo "[$(date)] Starting image build and push..."
export DOCKER_BUILDKIT = 1

docker buildx create --use --name vscode-dev-containers
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx build --push --platform linux/amd64,linux/arm64 -t ${CONTAINER_IMAGE_REPOSITORY} : "${TAG}" -f "${SCRIPT_PATH}/cache.Dockerfile" .

echo "[$(date)] Done!"
