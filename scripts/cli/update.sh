#!/usr/bin/env bash
set -e
docker compose pull
docker compose up -d --force-recreate
docker image prune -a -f
