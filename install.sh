#!/bin/bash

prompt_variable_values() {
    read -p "Please enter a comma separated list of IP addresses for each pihole instance: " ip_csv
    read -p "Please enter the password hash for the pihole instance(s): " auth
    read -p "Please enter the time adblocking should be disabled for in seconds: " seconds
    echo ""
}

update_env() {
    local ip_csv=$1
    local auth=$2
    local seconds=$3
    echo "IP_CSV=$ip_csv" > /dev/null
    echo "AUTH_TOKEN=$auth" > /dev/null
    echo "SECONDS=$seconds" > /dev/null
    cat <<EOF >.env
IP_CSV=$ip_csv
AUTH_TOKEN=$auth
SECONDS=$seconds
EOF
    echo "Environment file (.env) updated."
}

install_packages() {
    apt update && apt upgrade -y
    apt install -y git nodejs npm
    }

setup_repository() {
    git clone https://github.com/stuart-thomas-zoopla/pihole-quick-disable /var/www/html/disable
    cd /var/www/html/disable
    npm i

    CRON_COMMANDS=(
        "@reboot node /var/www/html/disable/server.js"
    )
    for command in "${CRON_COMMANDS[@]}"; do
        (
            crontab -l 2>/dev/null || true
            echo "$command"
        ) | crontab -
    done
}

main() {
    while true; do
        prompt_variable_values
        install_packages
        setup_repository
        update_env
        node /var/www/html/disable/server.js
        echo "Installation is complete and the server is running on port 3000."
    done
}

main