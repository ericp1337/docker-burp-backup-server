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
* `-e ENABLE_CRON_SUMMARY=0` - Enables emailing a daily summary (default: false) - *optional*
* `-e BURP_EMAIL="myemail@domain.tld"` - Sets the email address to send the daily summary to. - *only required if cron summary is enabled*
* `-e ENABLE_CRON_DEDUP=1` - Disables running dedup cron job (default: true) - *optional*

It is based on alpine linux with ssh disabled, for shell access whilst the container is running do `docker exec -it burp-server /bin/bash`.

## Setting up the application

See the [docs](http://burp.grke.org/docs.html)

## Versions

The version number corresponds to what version of burp server you want to run. This allows you to stay on a specific version of the software without having to worry about all of a sudden getting a different version that is incompatible with your configs.

### Available Versions

* latest - latest version 2 (once I finish setting up the stable version)
* 1.4.40 - Stable

## Updates

* The docker image is now based on alpine linux and configs are now located in `/etc/burp`.
* To monitor the logs of the container in realtime `docker logs -f burp-server`.

## Version History

+ **09/12/2016:** Base on Alpine Linux w/ ansible provisioning
+ **07/12/2016:** Inital Release
