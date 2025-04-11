#!/bin/bash

# This script checks and lists all users who have read (pull) access
# to a specified GitHub repository using the GitHub REST API.

# Function to check if required command-line arguments are passed
function helper {
    expected_cmd_args=2
    if [ $# -ne $expected_cmd_args ]; then
        echo "Please run the script with the required arguments."
        echo "Usage: ./script.sh <repo_owner> <repo_name>"
        exit 1
    fi
}

# GitHub API base URL
API_URL="https://api.github.com"

# GitHub credentials should be set as environment variables before running:
# export username="your_github_username"
# export token="your_github_token"
USERNAME=$username
TOKEN=$token

# Assigning script arguments to variables
REPO_OWNER=$1   # GitHub username or organization name
REPO_NAME=$2    # Repository name

# Function to make an authenticated GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users who have read access (pull permission) to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Use GitHub API and jq to extract logins of users with pull access
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display results
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Call helper function to validate input arguments
helper "$@"

# Start the process of listing users with read access
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access


