#!/usr/bin/env bash

# Function to start a simple HTTP server
start_server() {
  # Display startup message with server URL
  echo "Server started. Visit http://localhost:5000 to use it."
  
  # Create HTML content with current date
  # The date command gets the current system date and time
  message=$(echo "<html><body><p>Hello! Today's date is $(date).</p></body></html>")
  
  # Calculate the length of the message in characters
  # wc -c counts characters, <<< "$message" feeds the message as input
  # We subtract 1 because wc -c includes the newline character
  length=$(wc -c <<< "$message")
  
  # Build the HTTP response payload
  # HTTP/1.1 200 OK - Standard HTTP success response
  # Content-Length header tells the client how much data to expect
  # Empty line separates headers from body (required by HTTP protocol)
  payload="\
HTTP/1.1 200 OK
Content-Length: $((length-1))

$message"
  
  # Infinite loop to continuously serve requests
  while true
  do 
    # nc -l -p 5000: Listen on port 5000 for incoming connections
    # echo -ne "$payload": Output the HTTP response without adding newline
    # The response is piped to netcat to send it to the client
    echo -ne "$payload" | nc -l -p 5000
  done
}

# Call the function to start the server
start_server
