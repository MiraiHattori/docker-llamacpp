APT_PACKAGES_EXTRA ?= neovim emacs iputils-ping command-not-found bash-completion

all: download-model build-and-run-server ask1

# Download gghf models. Should return immediately if the models are already downloaded.
download-model:
	docker compose --profile download run --rm llama-model-download

# Builds server and run it. Skips build if already built
build-and-run-server:
	docker compose up -d llama-cpp

# build-and-run-server does not pull the latest image. upgrade the server and run
upgrade-and-run-server:
	docker compose pull llama-cpp && docker compose up -d --force-recreate llama-cpp

log-server:
	docker compose logs llama-cpp -f | less -R

build-tools:
	APT_PACKAGES_EXTRA="$(APT_PACKAGES_EXTRA)" docker compose --profile tools build continue-cli

# launches client
ask1: build-tools
	APT_PACKAGES_EXTRA="$(APT_PACKAGES_EXTRA)" docker compose --profile tools run --rm -it --volume ./workspace1:/workspace --volume ./dotcontinue1:/root/.continue continue-cli cn --readonly --config /root/.continue/config.yaml

# launches client
ask2: build-tools
	APT_PACKAGES_EXTRA="$(APT_PACKAGES_EXTRA)" docker compose --profile tools run --rm -it --volume ./workspace2:/workspace --volume ./dotcontinue2:/root/.continue continue-cli cn --readonly --config /root/.continue/config.yaml

# attaches to the existing client and execute bash
bash:
	docker compose --profile tools exec continue-cli /bin/bash

