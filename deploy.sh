#!/bin/bash

# Default values
ADMIN_URL="t3://localhost:7001"
USERNAME="your_username"
PASSWORD="your_password"
WAR_FILE="/path/to/your/app.war"
APP_NAME="YourApp"  # Replace with your application name

# Function to display script usage
function display_usage {
    echo "Usage: $0 -a <Admin_Server_URL> -u <username> -p <password> -w <path_to_war_file> -n <app_name>"
    echo "Options:"
    echo "  -a <Admin_Server_URL>      WebLogic Admin Server URL"
    echo "  -u <username>              WebLogic Admin username"
    echo "  -p <password>              WebLogic Admin password"
    echo "  -w <path_to_war_file>      Path to the WAR file"
    echo "  -n <app_name>              Name of the application"
    exit 1
}

# Parse command line options
while getopts ":a:u:p:w:n:" opt; do
    case $opt in
        a) ADMIN_URL="$OPTARG";;
        u) USERNAME="$OPTARG";;
        p) PASSWORD="$OPTARG";;
        w) WAR_FILE="$OPTARG";;
        n) APP_NAME="$OPTARG";;
        \?) echo "Invalid option: -$OPTARG" >&2
            display_usage;;
        :) echo "Option -$OPTARG requires an argument." >&2
            display_usage;;
    esac
done

# Command to redeploy application
/u01/app/jdk/bin/java -cp weblogic.jar weblogic.Deployer -adminurl "$ADMIN_URL" -user "$USERNAME" -password "$PASSWORD" -redeploy -name "$APP_NAME" "$WAR_FILE"

