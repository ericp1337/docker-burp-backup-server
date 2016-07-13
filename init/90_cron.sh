#!/bin/bash

if [ -n "$ENABLE_CRON_SUMMARY" ]
then
    if [ $ENABLE_CRON_SUMMARY == 1 ]
    then
        sed -i '6s/^#//' /etc/cron.d/bedup
    fi
else
    sed -i '6s/\([^#]\)/#\1/' /etc/cron.d/bedup
fi

if [ "$DISABLE_CRON_DEDUP" ]
then
    sed -i '11s/\([^#]\)/#\1/' /etc/cron.d/bedup
else
    sed -i '11s/^#//' /etc/cron.d/bedup
fi
