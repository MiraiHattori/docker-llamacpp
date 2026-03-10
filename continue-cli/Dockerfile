FROM node:lts-trixie

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_PACKAGES_DEFAULT="git ca-certificates ripgrep"
ARG APT_PACKAGES_EXTRA=""

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends ${APT_PACKAGES} ${APT_PACKAGES_EXTRA} \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g @continuedev/cli

WORKDIR /workspace
CMD ["cn", "--config", "/root/.continue/config.yaml"]
