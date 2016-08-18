#!/bin/bash

#This code was created as a way of making the traffic from the CASSA events or helpdesk to run through a VPN controled by CASSA. It should be run on the primary network node, at the highest tree point possible, to make sure we cover all the network traffic. 
#This code was last updated on the 18/08/2016 by Adam Foster (Evildeamond)
#Check the Github Commit message for update infomation.

#The pingCheck function pings the 8.8.8.8 IP (Googles Public DNS Server) with 1 packet, checks with grep if the ping function has sent back that it cannot ping the server, and assigns a value of 0 if it cannot.
pingCheck=$(ping -c 1 8.8.8.8 | grep ", 0% packet loss" | wc -l);
 
if [ $pingCheck = 0 ]; then
	echo "VPN is currently down"
	echo "Restarting the CASSA VPN..."
#The following lines forces the system to connect to the CASSA server via Point-to-Point Protocol daemon, and tunnels all the network traffic through it. 
	pppd  updetach noauth silent noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth"  ipparam vpn 
172.16.18.1:172.16.18.2
	sleep 5
	ip route replace default via 172.16.18.1
else
	echo "CASSA VPN Should be up."
fi
echo "CASSA VPN Should be up."

