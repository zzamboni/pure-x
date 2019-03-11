# Speficy fish version to use during build 
# docker build -t <image> --build-arg FISH_VERSION=<version>
ARG FISH_VERSION=3.0.0
FROM ohmyfish/fish:${FISH_VERSION}

# Redeclare ARG so its value is available after FROM (cf. https://github.com/moby/moby/issues/34129#issuecomment-417609075)
ARG FISH_VERSION
RUN printf "\nBuilding \e[38;5;27mFish-%s\e[m\n\n" ${FISH_VERSION}

# Install dependencies
USER root
RUN apk add \
    --no-cache \
    coreutils

RUN adduser --shell /usr/bin/fish -D pure
USER pure
WORKDIR /home/pure/.pure/
COPY --chown=pure:pure . /home/pure/.pure/

ENTRYPOINT ["fish", "-c"]
CMD ["echo $fish_config"]