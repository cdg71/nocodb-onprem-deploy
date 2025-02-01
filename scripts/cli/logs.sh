#!/usr/bin/env bash

# Constants
BOLD='\033[1m'
NC='\033[0m'

# Get the list of running containers
get_containers() {
    docker ps --format "{{.Names}}"
}

# Display menu and monitor selected container(s)
logs_menu() {
    local containers
    containers=($(get_containers)) # Get all container names as an array

    while true; do
        clear
        echo -e "${BOLD}Select a container to view logs:${NC}"
        for i in "${!containers[@]}"; do
            echo "$((i + 1)). ${containers[$i]}"
        done
        echo -e "A. All Containers"
        echo -e "0. Back to Main Menu"

        echo -e "\nEnter your choice: "
        read -r choice

        if [[ "$choice" =~ ^[0-9]+$ && "$choice" -ge 1 && "$choice" -le "${#containers[@]}" ]]; then
            local selected_container="${containers[$((choice - 1))]}"
            echo -e "\nShowing logs for container: ${BOLD}${selected_container}${NC}"
            docker logs -f "$selected_container"
        elif [[ "$choice" == "A" || "$choice" == "a" ]]; then
            echo -e "\nShowing logs for all containers."
            docker compose logs -f --tail 100
        elif [[ "$choice" == "0" ]]; then
            echo -e "\nReturning to main menu..."
            break
        else
            echo -e "\nInvalid choice. Please try again."
        fi
    done
}

# Run the logs menu
logs_menu
