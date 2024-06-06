FROM ruby:3-alpine

LABEL org.opencontainers.image.authors='Wolf Software <containers@wolfsoftare.com>'
LABEL org.opencontainers.image.vendor='Wolf Software'
LABEL org.opencontainers.image.licenses='MIT'
LABEL org.opencontainers.image.title='Gem Release Container'
LABEL org.opencontainers.image.description='Caretkaer Container'
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
		openssl=3.3.0-r2 \
		openssl-dev=3.3.0-r2 \
		&& \
	sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
	gem update --system && \
	gem install bundler -v '~> 2.5' && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/bash"]
