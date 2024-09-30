#!/bin/bash

# Start Program
while true; do
    ls
    echo "Do you want to delete files? (y/n)"
    read respo01

    if [[ $respo01 == "y" ]]; then
        echo "Insert the name of the file (or type 'cancel' to exit):"
        read del_file

        # Check if the user wants to cancel
        if [[ $del_file == "cancel" ]]; then
            exit
        else
            # Check if the file is make.sh or del.sh
            if [[ $del_file == "make.sh" || $del_file == "del.sh" ]]; then
                echo -e "\e[31mThose files cannot be deleted!!!\e[0m"
            else
                # Delete the specified file
                rm -rf "$del_file"
                echo -e "\e[32mOperation finished!!!\e[0m"
            fi
        fi
    else
        echo "Operation cancelled!!!"
        break
    fi
done

