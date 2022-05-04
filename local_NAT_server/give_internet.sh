#!/bin/sh
echo "Hey! Run me with sudo. You are to set your local PC to provide Interent connection to remote host in your loacal network. We are to set up your local PC as a NAT server to transfer packages from server in local network to outside. This is unsencure I think =) \n\n"
echo "This may be usefull for example in case if you have a server in local network. You can ssh it. But there is no Internet connection. But you need Internet connetction on your server.....\n\n Anyway....\n\n"
while true; do
	read -p "Are you TOTALY sure?[y/n]:" decision
	case $decision in
		[Yy]* ) echo "ok lets go"; break;;
		[Nn]* ) echo "sucker! bb"; exit;;
		* ) echo "Yes or No. Or yes or no.";;
	esac
done
read -p "Give me the name of interface via you can connect to your local server. [ex. eth0 or enp1]:" ETH
read -p "....and the name of interface for Internet:" WLAN
while true; do
	read -p "OK. Now we are to set up Internet forwarding from $WLAN(outside) to $ETH(local server). Is that correct? (hint: ifconfig)[y/n?]:" proceed
	case $proceed in
		[Yy]* ) echo "lets start"; break;;
		[Nn]* ) echo "you need to start over. I'm lazy. bb"; exit;;
		* ) echo "Yes or no.";;
	esac
done
echo "drop every INPUT..."
sleep 1
sudo iptables -P INPUT DROP  # drop every INPUT
echo "drop every FORWARD..."
sleep 1
sudo iptables -P FORWARD DROP    # drop every FORWARD
echo "accept loopback-INPUT..."
sleep 1
sudo iptables -A INPUT -i lo -j ACCEPT   # accept loopback-INPUT
echo "accept $ETH INPUT..."
sleep 1
sudo iptables -A INPUT -i $ETH -j ACCEPT # accept eth0 INPUT
echo "NAT-Translation..."
sleep 1
sudo iptables -t nat -A POSTROUTING -o $WLAN -j MASQUERADE   # NAT-Translation
echo "accept FORWARD-Traffic from $ETH..."
sleep 1
sudo iptables -A FORWARD -i $ETH -j ACCEPT   # accept FORWARD-Traffic from eth0
echo "accept FORWARD-Traffic as reply for existing connections..."
sleep 1
sudo iptables -A FORWARD -i $WLAN -o $ETH -m state --state ESTABLISHED,RELATED -j ACCEPT # accept FORWARD-Traffic as reply for existing connections"
echo "allow the local computer to access the internet..."
sleep 1
sudo iptables -A INPUT -i $WLAN -m state --state ESTABLISHED,RELATED -j ACCEPT # allow the local computer to access the internet
echo "allow pings on $WLAN..."
sleep 1
sudo iptables -A INPUT -i $WLAN -p icmp --icmp-type echo-request -j ACCEPT # allow pings on wlan0
echo "set up ip-forwarding..."
sleep 1
echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward
echo "All done! Youre awesome!!!"
sleep 1
exit
