#!/bin/sh
echo "You are to set new gateway for this machine. You should already set up your local host as a NAT-server"
sleep 1
read -p "Give me the local ip of your local host which has access to internet and set up as a NAT-router: [ex 192.168.10.200]" ip
while true; do
	read -p "You are ready for setting up a gateway $ip? [y/n]:" decision
	case $decision in
		[Yy]* ) echo "lets go"; break;;
		[Nn]* ) echo "you need to start over. Im lazy. bb"; exit;;
		* ) echo "yes or no.";;
	esac
done
pause 1
sudo ip route add 0.0.0.0 via $ip
echo "added route 0.0.0.0 via $ip. Now you should run give_internet.sh on your local host if you haven't done this yet. bb"
