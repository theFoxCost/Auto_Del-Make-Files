#!/bin/bash
echo "Do You Want To Make C# File (y/n):"
read resp1
echo "What Is File Name :"
read file_name
if [[ $resp1 == "y" ]]; then
	echo Loading....
	sleep 1
	echo >$file_name.cs
	echo "$file_name Succefuly Made!!!"
else 
	echo "Failed!!!"
fi

