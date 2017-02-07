FROM webdevops/base:alpine-3

VOLUME ["/data", "/etc/burp"]

EXPOSE 4971 4972

# Install Required System Packages
RUN /usr/local/bin/apk-upgrade \
    && /usr/local/bin/apk-install \
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

#RUN /usr/local/bin/apk-install \
#    bash bash-completion \
#    pciutils usbutils coreutils binutils findutils grep \
#    build-base gcc abuild binutils

COPY conf/ /opt/docker/

# Provision
RUN /opt/docker/bin/provision add --tag bootstrap --tag entrypoint burp-server \
    && /opt/docker/bin/bootstrap.sh \
    && rm -rf /tmp/*