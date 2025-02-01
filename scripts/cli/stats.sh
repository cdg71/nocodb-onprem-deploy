#!/usr/bin/env bash

# Constants
BOLD='\033[1m'
NC='\033[0m'

# Start monitoring
clear
echo -e "${BOLD}Starting container monitoring...${NC}"
echo -e "Press ${BOLD}Ctrl+C${NC} to stop monitoring and return to the main menu.\n"

# Trap Ctrl+C to stop monitoring and return
trap 'echo -e "\n\nStopping monitoring... Returning to main menu."; exit 0' INT

# Run monitoring
docker stats
