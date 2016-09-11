FROM webdevops/base:ubuntu-16.04
MAINTAINER Eric Pfeiffer

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="AGPLv3" \
      org.label-schema.name="burp - backup and restore program" \
      org.label-schema.url="http://burp.grke.net/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/computerfr33k/docker-burp-backup-server"

COPY conf/ /opt/docker/

RUN /opt/docker/bin/provision run --tag bootstrap --role burp-server \
    && /opt/docker/bin/bootstrap.sh

VOLUME ["/config", "/data"]

EXPOSE 4971 4972
