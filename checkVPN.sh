#!/bin/bash

pingCheck=$(ping -c 1 8.8.8.8 | grep ", 0% packet loss" | wc -l);
 
if [ $pingCheck = 0 ]; then
	echo "Restarting VPN as it is down :("
	pppd  updetach noauth silent noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth"  ipparam vpn 
172.16.18.1:172.16.18.2
	sleep 5
	ip route replace default via 172.16.18.1
else
	echo "VPN is up :)"
fi
echo "VPN SHOULD BE UP!"

