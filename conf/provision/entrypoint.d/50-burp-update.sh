#!/usr/bin/env bash

##
# Functions
##

# Params $1=version
dl_burp () {
    echo "Downloading burp v${1}"
    curl -o /tmp/burp.tar.gz -L "https://github.com/grke/burp/archive/${1}.tar.gz"
}

build_burp () {
    echo "Building..."
    mkdir -p /tmp/burp
    tar zxf /tmp/burp.tar.gz -C /tmp/burp

    cd /tmp/burp/*
    autoreconf -vif
    ./configure --prefix=/usr --sysconfdir=/etc/burp --localstatedir=/var
    make
}

install_burp () {
    echo "Installing..."
    cd /tmp/burp/*

    make install

    rm -rf /tmp/burp
}

# Check variable status
export VERSION=$(echo "$VERSION" | tr '[:upper:]' '[:lower:]')

# Test if installed
if (command -v /usr/sbin/burp >/dev/null 2>&1); then
    # Get burp version
    export INSTALLED_VERSION=`/usr/sbin/burp -v | cut -c 6-`
else
    printf "Burp not installed. Going to install version: %s\n" ${VERSION}
fi

dl_burp "2.0.52"
build_burp
install_burp