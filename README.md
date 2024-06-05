<!-- markdownlint-disable -->
<p align="center">
    <a href="https://github.com/ActionsToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/actionstoolbox/black-and-white-circle-256.png" alt="ActionsToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/actions/workflows/cicd.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/ActionsToolbox/gem-build-and-release-docker-image/cicd.yml?branch=master&label=build%20status&style=for-the-badge" alt="Github Build Status" />
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/blob/master/LICENSE.md">
        <img src="https://img.shields.io/github/license/ActionsToolbox/gem-build-and-release-docker-image?color=blue&label=License&style=for-the-badge" alt="License">
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image">
        <img src="https://img.shields.io/github/created-at/ActionsToolbox/gem-build-and-release-docker-image?color=blue&label=Created&style=for-the-badge" alt="Created">
    </a>
    <br />
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/releases/latest">
        <img src="https://img.shields.io/github/v/release/ActionsToolbox/gem-build-and-release-docker-image?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/releases/latest">
        <img src="https://img.shields.io/github/release-date/ActionsToolbox/gem-build-and-release-docker-image?color=blue&label=Released&style=for-the-badge" alt="Released">
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/releases/latest">
        <img src="https://img.shields.io/github/commits-since/ActionsToolbox/gem-build-and-release-docker-image/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/blob/master/.github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/blob/master/.github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/blob/master/.github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/ActionsToolbox/gem-build-and-release-docker-image/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
</p>

## Overview

In order to make [gem-build-and-release-action](https://github.com/ActionsToolbox/gem-build-and-release-action) run as fast as possible, we
want to prebuild the docker container that it uses, so that it does not need to be built everytime the action runs.

## Dockerfile

```
FROM ruby:3-alpine

LABEL org.opencontainers.image.authors='Wolf Software <containers@wolfsoftare.com>'
LABEL org.opencontainers.image.vendor='Wolf Software'
LABEL org.opencontainers.image.licenses='MIT'
LABEL org.opencontainers.image.title='Gem Release Container'
LABEL org.opencontainers.image.description='Build and publish your gem to RubyGems.org'
LABEL org.opencontainers.image.created="$(date --rfc-3339=seconds --utc)"
LABEL org.opencontainers.image.source='https://github.com/ActionsToolbox/gem-release-docker-image'
LABEL org.opencontainers.image.documentation='https://github.com/ActionsToolbox/gem-release-docker-image'

RUN apk update && \
	apk add --no-cache \
		bash=5.2.26-r0 \
		build-base=0.5-r3 \
		git=2.45.2-r0 \
		gnupg=2.4.5-r0 \
		gpg-agent=2.4.5-r0 \
		&& \
	sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
	gem install bundler -v '~> 2.5' && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/bash"]
```

This allows us to keep the action dockerfile to a bare minimum.

```
FROM wolfsoftwareltd/gem-release:latest

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
```

<br />
<p align="right"><a href="https://wolfsoftware.com/"><img src="https://img.shields.io/badge/Created%20by%20Wolf%20on%20behalf%20of%20Wolf%20Software-blue?style=for-the-badge" /></a></p>
