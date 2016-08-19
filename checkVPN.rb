ppp0Check1 = `ifconfig | grep -c ppp0`

if(ppp0Check1.chomp == "0") 
	puts "ppp0 interface non-existant, assuming tunnel down"
	puts "Attempting to reconnect PPP tunnel over SSH"

	system 'pppd updetach noauth silent nodeflate pty "/usr/bin/ssh jogw@cassa.org.au -i /root/.ssh/jogw sudo /usr/sbin/pppd nodetach notty noauth" 172.16.18.1:172.16.18.2'
	system 'sleep 10'

	ppp0Check2 = `ifconfig | grep -c ppp0`

	if(ppp0Check2.chomp == "1") then
		puts "PPP Tunnel interface is present on ppp0"
		puts "Replacing default route with ppp0 endpoint"
		
		system 'ip route replsce default via 172.16.18.1'

		puts "Tunnel appears to be active."
	else
		puts "There was an error creating the PPP interface, ppp0 does not exist."
		exit
	end
else
	puts "PPP Tunnel interface is present on ppp0."
end
