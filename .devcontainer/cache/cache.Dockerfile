FROM mcr.microsoft.com/vscode/devcontainers/repos/microsoft/vscode:dev as cache

ARG USERNAME = node
ARG CACHE_FOLDER = "/home/${USERNAME}/.devcontainer-cache"

COPY --chown = ${USERNAME} : ${USERNAME} . /repo-source-tmp/

RUN mkdir -p ${CACHE_FOLDER} && chown ${USERNAME} ${CACHE_FOLDER} /repo-source-tmp \
	&& su ${USERNAME} -c "\
		cd /repo-source-tmp \
		&& .devcontainer/cache/before-cache.sh . ${CACHE_FOLDER} \
		&& .devcontainer/prepare.sh . ${CACHE_FOLDER} \
		&& .devcontainer/cache/cache-diff.sh . ${CACHE_FOLDER}"
		
FROM mcr.microsoft.com/vscode/devcontainers/repos/microsoft/vscode:dev as dev-container

ARG USERNAME = node
ARG CACHE_FOLDER = "/home/${USERNAME}/.devcontainer-cache"

RUN mkdir -p "${CACHE_FOLDER}" \
	&& chown "${USERNAME} : ${USERNAME}" "${CACHE_FOLDER}" \
	&& su ${USERNAME} -c "git config --global codespaces-theme.hide-status 1"

COPY --from = cache ${CACHE_FOLDER}/cache.tar ${CACHE_FOLDER}/
