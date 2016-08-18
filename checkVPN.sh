#!/bin/bash

vpnCheck=$(ifconfig | grep ppp0 | wc -l);
 
if [ $vpnCheck = 0 ]; then
	echo "Restarting VPN as it is down :("
	pppd  updetach noauth silent noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth"  ipparam vpn 172.16.18.1:172.16.18.2
	sleep 10
	ip route replace default via 172.16.18.1
else
	echo "VPN is up :)"
fi

