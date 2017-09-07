FROM webdevops/base:alpine

VOLUME ["/data", "/etc/burp"]

EXPOSE 4971 4972

# Upgrade to Alpine Linux v3.6
RUN sed -i -e 's/v3\.5/v3.6/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade --available

# Install Required System Packages
RUN apk-upgrade\
    && apk-install \
    acl-dev \
    attr-dev \
    autoconf \
    automake \
    coreutils \
    g++ \
    gcc \
    git \
    libacl \
    libgcc \
    librsync \
    librsync-dev \
    libstdc++ \
    libtool \
    make \
    ncurses \
    ncurses-dev \
    openssl \
    openssl-dev \
    rsync \
    unzip \
    uthash-dev \
    zlib \
    zlib-dev

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="AGPLv3" \
      org.label-schema.name="Burp - backup and restore program" \
      org.label-schema.url="http://burp.grke.org/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/computerfr33k/docker-burp-backup-server"

COPY conf/ /opt/docker/

# Provision
RUN /opt/docker/bin/provision add --tag entrypoint burp-server \
    && /opt/docker/bin/bootstrap.sh \
    && docker-image-cleanup