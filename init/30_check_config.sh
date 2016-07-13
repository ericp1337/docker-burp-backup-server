#!/bin/bash
 
 # Copy config files if they don't exist
function isDirEmpty {
    if [ ! "$(ls -A /config)" ]
    then
        cp -r /defaults/. /config/
        chown -R abc:abc /config
    fi
}
 
function createIfMissing {
    if [ -f "/config/$1" ]
    then
        cp /defaults/$1 /config/$1
        chown -R abc:abc /config/$1
    fi
}

isDirEmpty

createIfMissing burp-server.conf
createIfMissing CA.cnf
createIfMissing notify_script
createIfMissing ssl_extra_checks_script
createIfMissing summary_script
createIfMissing timer_script
