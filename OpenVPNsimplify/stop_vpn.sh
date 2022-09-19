#!/bin/bash
if ["$1" == ""]; then
	echo "ERROR. Need full path to *.ovpn config for session you want to be stopped."
	exit
fi
openvpn3 session-manage --disconnect --config $1
sudo /etc/init.d/openvpn stop
