#!/bin/bash
# Define color codes for better visibility
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

sleep 2

# Define the array of file types
list_types=("txt" "py" "c" "cs" "exe" "dank" "os" "odt" "pdf" "rtf" "xls" "ods" "ssv" "ppt" "odp" "bat"
            "abk" "abb" "js" "cpp" "java" "html" "css" "php" "sql" "mdb" "json" "db" "sqlit" "sys"
            "dll" "ini" "log" "iso" "ttf" "wtf" "otf" "woff" "obj" "stl" "dwg" "img" "dmg")

# Display the file types in three rows
echo -e "${BLUE}List of file types:${NC}"
for ((i = 0; i < ${#list_types[@]}; i+=3)); do
    echo -e "$((i+1))) ${list_types[i]}   $((i+2))) ${list_types[$((i+1))]:-""}   $((i+3))) ${list_types[$((i+2))]:-""}"
done

# Prompt the user to select a file type
echo ""
sleep 1
echo -e "${YELLOW}Please select a file type by entering a number (1-${#list_types[@]}):${NC}"
read user_choice

# Use a case statement to map the user input to the corresponding file type
case $user_choice in
    [1-9]|[1-9][0-9])
        if [[ $user_choice -ge 1 && $user_choice -le ${#list_types[@]} ]]; then
            file_type=${list_types[$((user_choice-1))]}  # Get the file type based on input
            echo -e "${GREEN}You selected: $file_type${NC}"
        else
            echo -e "${RED}Invalid selection. Please enter a number between 1 and ${#list_types[@]}.${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}Invalid input. Please enter a valid number.${NC}"
        exit 1
        ;;
esac

echo ""
sleep 2
string="$file_type"
uppercase_string=${string^^}

echo -e "${YELLOW}Do You Want $uppercase_string To Make File (y/n):${NC}"
read resp1

if [[ $resp1 == "n" || $resp1 == "N" ]]; then
    echo -e "${RED}Exiting the program.${NC}"
    exit 0
fi

sleep 1
echo -e "${YELLOW}Please Select Your File Location:${NC}"
echo -e "  1-HERE\n  2-Custom"
read location

# Handle file location
if [[ $location == "1" ]]; then
    location=$(pwd)  # Use current directory
else
    echo -e "${YELLOW}PLZ type your location:${NC}"
    read custom_location
    location=$custom_location
fi

echo -e "${YELLOW}What Is File Name:${NC}"
read file_name

# Create the file if the response is 'y'
if [[ $resp1 == "y" || $resp1 == "Y" ]]; then
    echo "Loading...."
    sleep 1
    # Use sudo tee to handle file redirection with sudo permissions
    sudo tee "$location/$file_name.$file_type" > /dev/null <<EOF
EOF

    # Verify if file creation was successful
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}$file_name Successfully Made!!!${NC}"
    else
        echo -e "${RED}Failed to create $file_name!!!${NC}"
    fi
else
    echo -e "${RED}Failed!!!${NC}"
fi
