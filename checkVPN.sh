#!/bin/bash

# Script to attempt to maintain persistant PPP tunnel over SSH.
# Requires root privilage on both PPP endpoints. Recommend adding "jogw ALL=NOPASSWD:/usr/sbin/pppd" to your /etc/sudoers file on ssh target.

# Throw this in a crontab with */1 * * * * for maximium tunnel capacity.

vpnCheck=$(ifconfig | grep ppp0 | wc -l);
 
if [ $vpnCheck = 0 ]; then
	echo "ppp0 interface non-existant, assuming tunnel is down."
	echo "Attempting to reconnect PPP tunnel"
	
	# updetach = PPPD will detatch from current terminal device once connection established.
	# noauth = Peer authnetication not required, this option is privilaged.
	# silent = Will not transmit LCP packets to initiate a connection until a valid LCP packet is received from the peer.
	# nodeflate = No compression.
	# pty = Specify script to use for communication with PPP endpoint instead of a terminal device. Will spawn as child process.

	# nodetach = Don't  detach  from  the  controlling  terminal.
	# notty = Create character shunt to transfer characters over STDIN & STDOUT without being connected to a terminal device.
	# noauth = Peer authnetication not required, this option is privilaged.
	
	pppd updetach noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth" 172.16.18.1:172.16.18.2
	sleep 10
	echo "Replacing default route with PPP endpoint"
	ip route replace default via 172.16.18.1
else
	echo "PPP Tunnel Should be up."
fi
