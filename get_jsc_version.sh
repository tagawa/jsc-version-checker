#!/bin/bash

# Function to check JavaScriptCore usage for a given process
check_jsc() {
    local pid=$1
    local app_name=$2
    
    # Sample the process and grep for JavaScriptCore
    jsc_info=$(sample $pid 1 2>/dev/null | grep -i "com.apple.JavaScriptCore" | grep -v grep)
    
    if [ -n "$jsc_info" ]; then
        # Extract version using awk and remove the redundant part
        version=$(echo "$jsc_info" | awk -F'[()]' '{print $2}' | sed 's/^[0-9]* - //')
        echo "${app_name#,}: $version"
    fi
}

# Function to check all running applications
check_all_apps() {
    # Get list of running applications
    apps=$(ps aux | grep -i "/Applications/" | grep -v grep | awk '{print $2 "," $11}' | awk -F'/' '{print $1 "," $NF}' | sed 's/\.app.*$//')

    # Count total number of applications
    total_apps=$(echo "$apps" | wc -l)
    current_app=0

    # Initialize an empty array to store results
    declare -a results

    # Check each application
    while IFS=',' read -r pid app_name; do
        current_app=$((current_app + 1))
        printf "\rChecking application %d of %d: %s" $current_app $total_apps "${app_name#,}"
        
        result=$(check_jsc "$pid" "$app_name")
        if [ -n "$result" ]; then
            results+=("$result")
        fi
    done <<< "$apps"

    # Clear the progress line
    printf "\r%$(tput cols)s\r"

    # Display unique results
    if [ ${#results[@]} -eq 0 ]; then
        echo "No running applications found using JavaScriptCore."
    else
        echo "Applications using JavaScriptCore:"
        printf '%s\n' "${results[@]}" | sort -u
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    check_all_apps
else
    app_name="$1"
    echo "Checking $app_name..."
    # Find process
    app_process=$(ps aux | grep -i "$app_name" | grep Applications | grep -v grep | head -n 1)

    if [ -z "$app_process" ]; then
        echo "$app_name is not running."
        exit 1
    fi

    # Extract PID
    pid=$(echo $app_process | awk '{print $2}')

    result=$(check_jsc "$pid" "$app_name")
    
    if [ -z "$result" ]; then
        echo "Could not find JavaScriptCore information for $app_name."
    else
        echo "$result"
    fi
fi
