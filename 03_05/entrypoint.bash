#!/usr/bin/env bash

# =============================================================================
# ENTRYPOINT SCRIPT DOCUMENTATION
# =============================================================================
# This script serves as an entrypoint for a Docker container that:
# 1. Validates the bash version (requires version 5)
# 2. Checks if curl is installed
# 3. Retrieves the current date/time from Google's servers
# 4. Displays a greeting with the current date/time
# =============================================================================

# Function: bash_is_current_version
# Purpose: Checks if the current bash version is 5.x
# Returns: 0 (success) if bash version 5 is detected, 1 (failure) otherwise
# How it works: Uses 'bash --version' to get version info, then grep searches for 'version 5'
bash_is_current_version() {
  bash --version | grep -q 'version 5'
}

# Function: curl_is_installed
# Purpose: Verifies that curl is installed and working properly
# Returns: 0 (success) if curl is found and responds correctly, 1 (failure) otherwise
# How it works: 
#   - 'which curl' finds the curl executable (redirected to /dev/null to suppress output)
#   - 'curl --version' gets curl version info
#   - grep checks if the output starts with 'curl'
curl_is_installed() {
  &>/dev/null which curl &&
    curl --version | grep -q '^curl'
}

# Function: get_current_date
# Purpose: Retrieves the current date and time from Google's servers
# Returns: Formatted date string
# How it works:
#   1. Makes a silent, insecure HTTPS request to google.com with -I (headers only)
#   2. Extracts the 'Date' header from the response
#   3. Removes the 'Date: ' prefix using sed
#   4. Uses xargs to pass the date string to the 'date' command for formatting
# Note: This method gets the server's date/time, which is useful in containers
#       that might not have accurate system time
get_current_date() {
  curl --silent --insecure -I google.com |
    grep -E '^Date' |
    sed 's/^Date: //' |
      xargs -I {} date --date='{}'
}

# =============================================================================
# MAIN EXECUTION FLOW
# =============================================================================

# Step 1: Validate bash version
# If bash is not version 5, print error to stderr and exit with code 1
if ! bash_is_current_version
then
  >&2 echo "ERROR: Bash not installed or not the right version."
  exit 1
fi

# Step 2: Validate curl installation
# If curl is not installed or not working, print error to stderr and exit with code 1
if ! curl_is_installed
then
  >&2 echo "ERROR: Curl is not installed."
  exit 1
fi

# Step 3: Display greeting with current date/time
# Uses command substitution $(...) to execute get_current_date function
# and embed the result in the echo statement
echo "Hello! The current date and time is $(get_current_date)"
