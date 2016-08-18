#!/bin/bash

#This code was created as a way of making the traffic from the CASSA events or helpdesk to run through a VPN controled by CASSA. It should be run on the primary network node, at the highest tree point possible, to make sure we cover all the network traffic. 
#This code was last updated on the 19/08/2016 by David Maxwell (FireGrey)
#Check the Github Commit message for update infomation.

vpnCheck=$(ifconfig | grep ppp0 | wc -l);
 
if [ $vpnCheck = 0 ]; then
	echo "CASSA VPN is currently down"
	echo "Restarting the CASSA VPN..."
	#The following lines forces the system to connect to the CASSA server via Point-to-Point Protocol deamon, and tunnels all the network traffic through it. 
	pppd  updetach noauth silent noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth"  ipparam vpn 172.16.18.1:172.16.18.2
	sleep 10
	ip route replace default via 172.16.18.1
else
	echo "CASSA VPN Should be up."
fi
echo "CASSA VPN Should be up."

