#/bin/bash
# Author: 376811578@qq.com
# Function:
#   ping当前网络可用地址
for siteip in $(seq 1 254)
do
	site="192.168.1.${siteip}"
	ping -c1 -W1 ${site} &> /dev/null
	if [ "$?" == "0" ];
	then
		echo "$site is UP"
	fi
done
