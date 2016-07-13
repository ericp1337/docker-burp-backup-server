# computerfr33k/burp-server

[Burp](http://burp.grke.org/) is a network backup and restore program. It attempts to reduce network traffic and the amount of space that is used by each backup.

## Usage

```
docker create \
    --name="burp-server" \
    -v /path/to/config/data:/config \
    -v /path/to/backups:/data \
    -v /etc/localtime:/etc/localtime:ro \
    -e PGID=<gid> -e PUID=<uid> \
    -p 4971:4971 -p 4972:4972 \
    computerfr33k/burp-server:<VERSION>
```

**Parameters**

* `-p 4971 -p 4972` - the port(s)
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - Configuration file location
* `-v /data` - Location for backups
* `-e PGID` for GroupID - see below for explanation - *optional*
* `-e PUID` for UserID - see below for explanation - *optional*
* `-e ENABLE_CRON_SUMMARY=1` - Enables emailing a daily summary - *optional*
* `-e BURP_EMAIL="myemail@domain.tld"` - Sets the email address to send the daily summary to. - *only required if cron summary is enabled*
* `-e DISABLE_CRON_DEDUP=1` - Disables running dedup cron job - *optional*

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it burp-server /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application

*Please Note: /etc/burp is located as /config in the docker container.*

See the [docs](http://burp.grke.org/docs.html)

## Versions

The version number corresponds to what version of burp server you want to run. This allows you to stay on a specific version of the software without having to worry about all of a sudden getting a different version that is incompatible with your configs.

### Available Versions

* latest - latest version 2 (once I finish setting up the stable version)
* 1.4.40 - Stable

## Updates

* To monitor the logs of the container in realtime `docker logs -f burp-server`.

## Version History

+ **07/12/2016:** Inital Release
