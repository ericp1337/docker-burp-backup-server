#!/bin/bash

# test if we need to run the update scripts
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0

# run apt-select script to find fastest up to date mirror
cd /defaults || exit
echo "finding fastest mirror"
apt-select -t 3 -m up-to-date && \
cp /etc/apt/sources.list /etc/apt/sources.list.backup && \
mv sources.list /etc/apt/

# check for and install any updates
echo "We are now refreshing packages from apt repositories, this *may* take a while"
apt-get update
apt-get --only-upgrade install -yqq $APTLIST
