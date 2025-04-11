#!/bin/bash

# Function to check required arguments
function helper {
    expected_cmd_args=2
    if [ $# -ne $expected_cmd_args ]; then
        echo "Please run the script with the required arguments."
        echo "Usage: ./script.sh <repo_owner> <repo_name>"
        exit 1
    fi
}

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token (set as env variables)
USERNAME=$username
TOKEN=$token

# User and Repository information from script arguments
REPO_OWNER=$1
REPO_NAME=$2

# Function to call GitHub API with GET
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main
helper "$@"
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access

