#!/bin/bash
echo "Please Enter you Ip Adress :"
read ip
sleep 1
echo "Enter Username :"
read user_name
sleep 1
sleep 3
loading.....
ssh $user_name@$ip
