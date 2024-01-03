#!/bin/bash

# Default values
ADMIN_URL="t3://localhost:7001"
USERNAME="your_username"
PASSWORD="your_password"
WAR_FILE="/path/to/your/app.war"

# Function to display script usage
function display_usage {
    echo "Usage: $0 -a <Admin_Server_URL> -u <username> -p <password> -w <path_to_war_file>"
    echo "Options:"
    echo "  -a <Admin_Server_URL>      WebLogic Admin Server URL"
    echo "  -u <username>              WebLogic Admin username"
    echo "  -p <password>              WebLogic Admin password"
    echo "  -w <path_to_war_file>      Path to the WAR file"
    exit 1
}

# Parse command line options
while getopts ":a:u:p:w:" opt; do
    case $opt in
        a) ADMIN_URL="$OPTARG";;
        u) USERNAME="$OPTARG";;
        p) PASSWORD="$OPTARG";;
        w) WAR_FILE="$OPTARG";;
        \?) echo "Invalid option: -$OPTARG" >&2
            display_usage;;
        :) echo "Option -$OPTARG requires an argument." >&2
            display_usage;;
    esac
done

# Command to redeploy application
java -cp $MW_HOME/wlserver/server/lib/weblogic.jar weblogic.Deployer -adminurl "$ADMIN_URL" -user "$USERNAME" -password "$PASSWORD" -redeploy "$WAR_FILE"
