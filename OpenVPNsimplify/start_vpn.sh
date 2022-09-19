#!/bin/bash
if ["$1" == ""]; then
	echo "Error. Need path to .ovpn config"
	exit
fi
openvpn3 config-remove --config $1
openvpn3 config-import --config $1
openvpn3 session-start --config $1
