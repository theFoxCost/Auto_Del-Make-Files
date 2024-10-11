#!/bin/bash

# Define the function before it's called
function addone {
    echo "WAIT PLEASE!!!"
    sleep 2
    echo "ADD NAME FOR YOUR SESSION!!!"
    read session_name
    sleep 2
    tmux new -s $session_name
}
echo "Do you want to install TMUX!!"
read install_resp

if [ $install_resp == "y" ]; then
	sudo apt install tmux
	sleep 1
else
	# Prompt user for input
	echo "Do you want to make tmux now!! (y/n)"
	read resp

	# Conditional based on user input
	if [[ $resp == "y" ]]; then
    		addone
	else
    		echo "Operation Cancelled !!"
	fi
fi
