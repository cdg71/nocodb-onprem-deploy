#!/usr/bin/env bash
set -e

echo "This operation will remove all Docker containers, networks, volumes and optionally images and bind-mounted directories."

# Ask whether to keep images
echo "Do you want to keep Docker images? This will prevent them from being deleted during the purge."
read -p "Keep images? [y/N]: " -r KEEP_IMAGES

# Step 5: Ask about purging bind-mounted directories (e.g., ./data)
read -p "Do you want to delete the './data' directory and its contents? [y/N]: " -r DELETE_DATA

# Warn about irreversibility and confirm
read -p "This action is irreversible. Continue? [y/N]: " -r CONFIRM_UNINSTALL
if [[ ! $CONFIRM_UNINSTALL =~ ^[Yy]$ ]]; then
    echo "Operation canceled."
    exit 1
fi

# Stop all running containers
echo "Stopping all running Docker containers..."
docker compose down

# Purge Docker resources
if [[ $KEEP_IMAGES =~ ^[Yy]$ ]]; then
    echo "Purging Docker containers, networks, and volumes, but keeping images..."
    docker container prune -f
    docker network prune -f
    docker volume prune -f
else
    echo "Purging Docker containers, images, networks, and volumes..."
    docker system prune -a -f
    docker volume prune -f
fi

# Purge bind-mounted directories
if [ -d ./data ]; then
    echo "The directory './data' contains bind-mounted volumes."
    if [[ $DELETE_DATA =~ ^[Yy]$ ]]; then
        echo "Deleting './data' directory..."
        rm -rf ./data
        echo "'./data' directory has been deleted."
    else
        echo "'./data' directory has been preserved."
    fi
else
    echo "No './data' directory found to delete."
fi

# Completion message
echo "Uninstallation completed successfully."
