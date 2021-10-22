#!/bin/sh

# start cron
/usr/sbin/crond -f -l 8
export RULES_GROUP_ID=1
# python3 /usr/src/app/rules_consumer.py