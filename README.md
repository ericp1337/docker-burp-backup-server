# Docker Image

[![](https://images.microbadger.com/badges/image/computerfr33k/burp-server.svg)](http://microbadger.com/images/computerfr33k/burp-server "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/computerfr33k/burp-server.svg)](http://microbadger.com/images/computerfr33k/burp-server "Get your own version badge on microbadger.com")

# Build

[![Build Status](https://travis-ci.org/computerfr33k/docker-burp-backup-server.svg?branch=master)](https://travis-ci.org/computerfr33k/docker-burp-backup-server)

# computerfr33k/burp-server

[Burp](http://burp.grke.org/) is a network backup and restore program. It attempts to reduce network traffic and the amount of space that is used by each backup.

## Usage

```
docker create \
    --name="burp-server" \
    -v /path/to/config/dir:/etc/burp \
    -v /path/to/backups:/data \
    -p 4971:4971 -p 4972:4972 \
    computerfr33k/burp-server:<VERSION>
```

**Parameters**

* `-p 4971 -p 4972` - the port(s)
* `-v /etc/burp` - Configuration file location
* `-v /data` - Location for backups
* `-e ENABLE_CRON_DEDUP=1` - Enables burp dedup (default: true) - *optional*

Otherwise you can use docker compose. Just edit the `docker-compose.yml` file and run `docker-compose up -d burp-server` to start the server in the background.

It is based on alpine linux with ssh disabled, for shell access whilst the container is running do `docker exec -it burp-server /bin/bash` or with docker compose `docker-compose exec burp-server /bin/bash`.

## Setting up the application

See the [docs](http://burp.grke.org/docs.html)

## Versions

The version number corresponds to what version of burp server you want to run. This allows you to stay on a specific version of the software without having to worry about all of a sudden getting a different version that is incompatible with your configs.

### Available Versions

[Tags](https://hub.docker.com/r/computerfr33k/burp-server/tags/)

* latest: Most recent burp release. (v2)
* 1.4.40-2 has breaking changes from 1.4.40 due to being based on a new docker image.

## Updates

* The docker image is now based on alpine linux and configs are now located in `/etc/burp`.
* To monitor the logs of the container in realtime `docker logs -f burp-server` or with docker compose `docker-compose logs -f burp-server`.

## Version History

+ **09/12/2016:** Base on Alpine Linux w/ ansible provisioning
+ **07/12/2016:** Inital Release
