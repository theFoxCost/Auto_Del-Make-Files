#!/bin/bash

# Define color codes for better visibility
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

sleep 2

# Define the array of file types (expanded list)
list_types=(
    "txt" "py" "c" "cs" "exe" "dank" "os" "odt" "pdf" "rtf" "xls" "ods" "ssv" "ppt" "odp" "bat"
    "abk" "abb" "js" "cpp" "java" "html" "css" "php" "sql" "mdb" "json" "db" "sqlit" "sys"
    "dll" "ini" "log" "iso" "ttf" "wtf" "otf" "woff" "obj" "stl" "dwg" "img" "dmg"
    "md" "xml" "sh" "rb" "go" "swift" "kt" "rs" "pl" "vb" "asp" "aspx" "jsp" "ts" "vue"
    "tsx" "scss" "sass" "less" "coffee" "erl" "hs" "lua" "m" "pas" "r" "sqlx" "yml" "yaml"
    "tex" "conf" "cfg" "dat" "bin" "bak" "tmp" "app" "apk" "deb" "rpm" "cab" "msi" "vbs"
    "ps1" "psm1" "psd1" "ps1xml" "pssc" "csh" "ksh" "fish" "zsh"
)

# Function to display file types in three columns
display_file_types() {
    local total=${#list_types[@]}
    local cols=3
    echo -e "${BLUE}List of file types:${NC}"
    for ((i = 0; i < total; i+=cols)); do
        line=""
        for ((j = 0; j < cols; j++)); do
            index=$((i + j))
            if [[ $index -lt $total ]]; then
                line+="$((index+1))) ${list_types[index]}   "
            fi
        done
        echo -e "$line"
    done
}

# Display the file types
display_file_types

# Prompt the user to select a file type or choose custom
echo ""
sleep 1
echo -e "${YELLOW}Please select a file type by entering a number (1-${#list_types[@]}) or type 'C' for Custom:${NC}"
read user_choice

# Function to handle selection
handle_selection() {
    local choice=$1
    if [[ $choice =~ ^[0-9]+$ ]]; then
        if [[ $choice -ge 1 && $choice -le ${#list_types[@]} ]]; then
            file_type=${list_types[$((choice-1))]}
            echo -e "${GREEN}You selected: $file_type${NC}"
        else
            echo -e "${RED}Invalid selection. Please enter a number between 1 and ${#list_types[@]}.${NC}"
            exit 1
        fi
    elif [[ $choice =~ ^[Cc]$ ]]; then
        echo -e "${YELLOW}Please enter your custom file type (without dot):${NC}"
        read custom_type
        # Validate custom_type (optional: add more validation as needed)
        if [[ -z "$custom_type" ]]; then
            echo -e "${RED}File type cannot be empty.${NC}"
            exit 1
        fi
        file_type=$custom_type
        echo -e "${GREEN}You entered custom file type: $file_type${NC}"
    else
        echo -e "${RED}Invalid input. Please enter a valid number or 'C' for Custom.${NC}"
        exit 1
    fi
}

# Handle the user selection
handle_selection "$user_choice"

echo ""
sleep 2

# Convert file type to uppercase for the prompt
uppercase_string=${file_type^^}

echo -e "${YELLOW}Do You Want to Make a $uppercase_string File? (y/n):${NC}"
read resp1

# Exit if user answers 'n' or 'N'
if [[ $resp1 == "n" || $resp1 == "N" ]]; then
    echo -e "${RED}Exiting the program.${NC}"
    exit 0
elif [[ $resp1 != "y" && $resp1 != "Y" ]]; then
    echo -e "${RED}Invalid response. Exiting the program.${NC}"
    exit 1
fi

sleep 1

# Select file location
echo -e "${YELLOW}Please Select Your File Location:${NC}"
echo -e "  1 - HERE (current directory)"
echo -e "  2 - Custom (enter your own path)"
read location_choice

# Handle file location selection
if [[ $location_choice == "1" ]]; then
    location=$(pwd)  # Use current directory
    echo -e "${GREEN}Selected location: $location${NC}"
elif [[ $location_choice == "2" ]]; then
    echo -e "${YELLOW}Please type your desired location (absolute path):${NC}"
    read custom_location
    # Check if the directory exists
    if [[ -d "$custom_location" ]]; then
        location=$custom_location
        echo -e "${GREEN}Selected custom location: $location${NC}"
    else
        echo -e "${RED}Directory does not exist. Exiting.${NC}"
        exit 1
    fi
else
    echo -e "${RED}Invalid selection. Exiting.${NC}"
    exit 1
fi

echo -e "${YELLOW}What Is the File Name (without extension):${NC}"
read file_name

# Validate file name
if [[ -z "$file_name" ]]; then
    echo -e "${RED}File name cannot be empty. Exiting.${NC}"
    exit 1
fi

# Full file path
file_path="$location/$file_name.$file_type"

# Check if file already exists
if [[ -e "$file_path" ]]; then
    echo -e "${YELLOW}File already exists. Do you want to overwrite it? (y/n):${NC}"
    read overwrite_choice
    if [[ $overwrite_choice != "y" && $overwrite_choice != "Y" ]]; then
        echo -e "${RED}File not created. Exiting.${NC}"
        exit 1
    fi
fi

# Create the file
echo "Loading...."
sleep 1

# Create the file without using sudo unless necessary
touch "$file_path" 2>/dev/null

# Check if touch was successful
if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}$file_name.$file_type Successfully Made!!!${NC}"
else
    # If touch failed, try using sudo
    echo -e "${RED}Failed to create the file without sudo. Trying with sudo...${NC}"
    sudo touch "$file_path" 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}$file_name.$file_type Successfully Made with sudo!!!${NC}"
    else
        echo -e "${RED}Failed to create $file_name.$file_type even with sudo. Check your permissions.${NC}"
        exit 1
    fi
fi

# Optionally, you can add content to the file or leave it empty
# Example: Adding a comment based on file type
case "${file_type,,}" in  # Convert to lowercase for case matching
    "py")
        echo "#!/usr/bin/env python3" >> "$file_path"
        ;;
    "sh")
        echo "#!/bin/bash" >> "$file_path"
        ;;
    "js")
        echo "// JavaScript file" >> "$file_path"
        ;;
    "html")
        echo "<!-- HTML file -->" >> "$file_path"
        ;;
    *)
        # For other file types, you can add default content or leave it empty
        ;;
esac

echo -e "${GREEN}Optional content added to $file_path${NC}"
