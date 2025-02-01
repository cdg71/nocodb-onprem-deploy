#!/usr/bin/env bash
set -e
BOLD='\033[1m'
NC='\033[0m'
PROJECT_ROOT="$(realpath "$(dirname "$0")/../..")"

cd $PROJECT_ROOT

management_menu() {
    local exit_requested=false
    while [ "$exit_requested" = false ]; do
        clear
        echo -e "\n${BOLD}Service Management${NC}"
        echo -e " 1. Start / Install"
        echo -e " 2. Stop"
        echo -e " 3. Restart"
        echo -e " 4. Update"
        echo -e " 5. Logs"
        echo -e " 6. Monitor"
        echo -e " 7. Inspect"
        echo -e " 8. Uninstall"
        echo -e " 0. Exit"

        echo -e "\nEnter your choice: "
        read -r choice

        case $choice in
        1) clear && sudo bash "./scripts/cli/start.sh";;
        2) clear && sudo bash "./scripts/cli/stop.sh";;
        3) clear && sudo bash "./scripts/cli/stop.sh" && sudo bash "./scripts/cli/start.sh";;
        4) clear && sudo bash "./scripts/cli/update.sh";;
        5) clear && sudo bash "./scripts/cli/logs.sh";;
        6) clear && sudo bash "./scripts/cli/stats.sh";;
        7) clear && sudo bash "./scripts/cli/inspect.sh";;
        8) clear && sudo bash "./scripts/cli/uninstall.sh";;
        0) echo "Exiting..."; exit_requested=true ;;
        *) echo "Invalid choice. Please try again." ;;
        esac

        # Pause before reloading the menu
        if [ "$exit_requested" = false ]; then
            read -p "Press Enter to continue..." -r
        fi
    done
}

management_menu
