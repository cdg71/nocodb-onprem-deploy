#!/bin/bash

# Load environment variables
source /usr/local/bin/docker.env

# Define variables
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DUMP_FILENAME="dump_$TIMESTAMP.dump"
DUMP_PATH="/postgres-dumps"

# Dump command with pg_dump
env PGPASSWORD=$POSTGRES_PASSWORD pg_dump -h postgres -U $POSTGRES_USER -d $POSTGRES_DB -F c -f "$DUMP_PATH/$DUMP_FILENAME"

# Check if the dump was successful
if [ $? -eq 0 ]; then
  echo "Dump successful: $DUMP_FILENAME"
else
  echo "Error during dump." >&2
  exit 1
fi

# Dump rotation management
cd "$DUMP_PATH"
if [ $(ls -1t | wc -l) -gt $PG_DUMPS_TO_KEEP ]; then
  echo "Dumps rotation..."
  ls -1t | tail -n +$((PG_DUMPS_TO_KEEP + 1)) | xargs rm -f
  echo "Rotation done."
fi
