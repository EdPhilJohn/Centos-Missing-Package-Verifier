#!/bin/bash	
# Program to find missing packages and installing them automatically
# Written by Amal Edward
# Email - edphiljohn@gmail.com

uPackages=()
echo "Scanning to see if anything's missing...................."
if [[ -f uPackages.log ]];then
        rm uPackages.log
fi

mapfile -t rpmArray < rpm.txt
readarray -t iPackages < <(rpm -qa)  
for i in "${rpmArray[@]}"
do 
	for j in "${iPackages[@]}"
	do
		temp=0
		if [[ "$i" == "$j" ]];then
			temp=1
			break
		fi
	done
	if [[ "$temp" == 0 ]];then
		echo $i >> uPackages.log
		uPackages+=$i
	fi	
		
done
clear
if [[ ! -f uPackages.log ]];then
	echo "No Packages Missing"
else
	echo "Packages Missing are : "
	cat uPackages.log
	echo "............................................."
	echo "Missing packages are shown in uPackages.log"
fi

# In the below rpm command, add the location of the rpm package as /something/whatever/$i
for i in  "${uPackages[@]}"
do
	yum install $i -y
done

