#!/bin/bash

EXIT_ON_ERROR=true
staging_dir="./tmp"

# Import other scripts
source ./scripts/fab_functions.sh
source ./scripts/replace_metadata.sh

# # Load abbreviations from the naming convention file
# declare -A abbreviations
# while IFS='=' read -r key value; do
#     abbreviations["$key"]="$value"
# done < <(get_all_abbreviations)

# Parse command-line arguments
parse_args() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --capacity-name) capacity_name="$2"; shift ;;
            --spn-auth-enabled) spn_auth_enabled="$2"; shift ;;
            --upn-objectid) upn_objectid="$2"; shift ;;
            --username) username="$2"; shift ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done
}

# [deprecated] Read configuration from a file
read_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Error: Config file not found at $CONFIG_FILE"
        exit 1
    fi

    while IFS=": " read -r key value; do
        # Remove any \r characters and extra spaces
        key=$(echo "$key" | tr -d '\r' | xargs)
        value=$(echo "$value" | tr -d '\r' | tr -d '"' | xargs)

        # Skip empty lines and comments
        if [[ ! "$key" =~ ^# && -n "$key" ]]; then
            export "$key"="$value"
        fi
    done < "$CONFIG_FILE"
}

# Create a staging directory
create_staging() {
    echo -e "\n_ creating staging directory..."
    mkdir -p "$staging_dir" || { echo "Failed to create staging directory"; exit 1; }
    cp -r ./workshop_template/* "$staging_dir/" || { echo "Failed to copy files to staging directory"; exit 1; }
    echo "* Done"
}

# Clean up the staging directory
clean_up_staging() {
    echo -e "\n_ cleaning up staging directory..."
    rm -r "$staging_dir" || { echo "Failed to remove staging directory"; exit 1; }
    echo "* Done"
}
