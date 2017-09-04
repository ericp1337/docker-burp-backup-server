#!/usr/bin/env sh

if [ -f /tmp/updates-disabled ]; then
    NO_UPDATES=1
    return 0
else
    NO_UPDATES=0
fi

VERSION=$(echo "$VERSION" | tr '[:upper:]' '[:lower:]')

if [ "$VERSION" == "latest" ]; then
    REMOTE_VERSION=$(curl -s 'https://api.github.com/repos/grke/burp/releases/latest' | jq -r '.tag_name')
else
    REMOTE_VERSION="$VERSION"
fi

if [ -f /.installed_version ]; then
    INSTALLED_VERSION=$(cat /.installed_version.txt)
else
    INSTALLED_VERSION=""
fi

if [ "$INSTALLED_VERSION" != "$REMOTE_VERSION" ]; then
    UPDATE_AVAILABLE=1
    if [ -d /tmp/burp ]; then
        rm -rf /tmp/burp
    fi

    mkdir -p ~/.ssh
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    git clone -b "$REMOTE_VERSION" --single-branch --depth 1 https://github.com/grke/burp.git /tmp/burp
    pushd /tmp/burp

    autoreconf -vif
    ./configure --prefix=/usr --sysconfdir=/etc/burp --localstatedir=/data --disable-ipv6
    make
    make install

    if [ ! -f /etc/burp/burp-server.conf ]; then
        make install-configs
    fi

    echo "$REMOTE_VERSION" > /.installed_version.txt

    if [ "$VERSION" != "latest" ]; then
        touch /tmp/updates-disabled
    fi

else
    UPDATE_AVAILABLE=0
fi