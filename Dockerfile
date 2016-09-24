FROM webdevops/base:alpine-3

VOLUME ["/data", "/etc/burp"]

EXPOSE 4971 4972

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
    autoconf \
    automake \
    libtool \
    unzip
    
COPY conf/ /opt/docker/
    
RUN /opt/docker/bin/provision add --tag bootstrap --tag entrypoint burp-server \
    && /opt/docker/bin/bootstrap.sh \
    && rm -rf /tmp/* \
    
    # Remove Dev Libs    
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
    git \
    autoconf \
    automake \
    libtool \
