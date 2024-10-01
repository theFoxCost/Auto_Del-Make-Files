#!/bin/bash

# Prompt for destination directory
echo "Enter Location Of SENDING: "
read dist

# Prompt for file or folder location
echo "Enter Location Of File Or Folder: "
read file_loc

# Prompt for IP address
echo "Enter IP Address: "
read ip

# Prompt for username
echo "Enter Username: "
read user_name

# Check for empty inputs
if [[ -z "$dist" || -z "$file_loc" || -z "$ip" || -z "$user_name" ]]; then
    echo "All fields are required. Please try again."
    exit 1
fi

# Pause for a moment before executing
sleep 1

# Execute the scp command with error handling
if scp -r "$file_loc" "$user_name@$ip:$dist"; then
    echo "File transfer completed successfully!"
else
    echo "Error during file transfer. Please check your inputs."
    exit 1
fi

