#!/bin/bash
clear

# GitHub Repository
GIT_CMD="https://raw.githubusercontent.com/ajaysams/All/main/AUTOKILL_SERVICE"

# List of services to download
SERVICES=("kill-vme" "kill-vle" "kill-tro" "kill-ssh")

# Loop to download and set service permissions
for service in "${SERVICES[@]}"; do
    FILE_PATH="/etc/systemd/system/${service}.service"
    
    # Download service file
    wget -q -O "$FILE_PATH" "${GIT_CMD}/${service}.service"
    
    # Check if file was successfully downloaded
    if [[ ! -f "$FILE_PATH" ]]; then
        echo "Failed to download ${service}.service"
        exit 1
    fi

    # Give execution permission
    chmod +x "$FILE_PATH"
    
    # Enable and restart service
    systemctl daemon-reload
    systemctl enable "$service"
    systemctl restart "$service"
    
    echo "Successfully installed and started ${service}"
done
