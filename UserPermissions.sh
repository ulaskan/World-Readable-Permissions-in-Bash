#! /bin/bash
# Author: ulaskan
# Date: 16 Oct 2016

clear
echo
echo "Please specify output file name: "
read file
touch $file

Cyan='\033[1;36m'
Norm='\033[0m'

users=( $(egrep -v 'nologin|false|root' /etc/passwd | cut -d: -f1) )
uLen=${#users[@]} 

for (( i=0; i<${uLen}; i++));
do 
	echo -e "\tUser, ${Cyan}${users[i]}${Norm} has following files accessible to everyone: " | tee -a $file	
	UserHome=( $(egrep "${users[i]}" /etc/passwd | cut -d: -f6) ) 
	echo "Searching, $UserHome ..." | tee -a $file
	find $UserHome -perm -o+r 2> /dev/null | tee -a $file
done
echo
