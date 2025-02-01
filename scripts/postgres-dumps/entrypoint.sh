#!/bin/bash

# Load environment variables
source /usr/local/bin/docker.env

# Install necessary tools
apk add --no-cache postgresql-client bash

# Configure the cron job from the environment variable
echo "${PG_DUMPS_CRON} /usr/local/bin/dump.sh >> /var/log/cron.log 2>&1" | crontab -

# Start cron in the foreground to monitor tasks
crond -f -d 8
