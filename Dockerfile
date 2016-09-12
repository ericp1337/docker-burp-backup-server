FROM webdevops/base:alpine-3

VOLUME ["/data", "/etc/burp"]

EXPOSE 4971 4972

COPY conf/ /opt/docker/

RUN /usr/local/bin/apk-upgrade \
    && /usr/local/bin/apk-install \
    librsync \
    librsync-dev \
    zlib-dev \
    zlib \
    openssl-dev \
    openssl \
    ncurses-dev \
    ncurses \
    acl-dev \
    libacl \
    attr-dev \
    libattr \
    make \
    gcc \
    g++ \
    make \
    git \
    rsync \
    libstdc++ \
    libgcc \
    # Build and install burp server
    && /opt/docker/bin/provision add --tag bootstrap --tag entrypoint burp-server \
    && /opt/docker/bin/bootstrap.sh \
    && rm -rf /tmp/* \
    # Remove Dev Libraries
    && apk del \
    librsync-dev \
    zlib-dev \
    openssl-dev \
    ncurses-dev \
    acl-dev \
    attr-dev \
    make \
    gcc \
    g++ \
    make \
    git
