#!/usr/bin/env sh

DEFAULT_ENABLE_CRON_DEDUP=1
_enable_cron_dedup="${ENABLE_CRON_DEDUP:-DEFAULT_ENABLE_CRON_DEDUP}"

if [ "$_enable_cron_dedup" == "1" ]; then
    cp ./files/burp-bedup.sh.template /etc/cron.weekly/burp-bedup.sh
    chmod 755 /etc/cron.weekly/burp-bedup.sh
else
    if [ -f /etc/cron.weekly/burp-bedup.sh ]; then
        rm /etc/cron.weekly/burp-bedup.sh
    fi
fi
