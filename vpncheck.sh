#!/bin/bash

#run status of vpn put output in /tmp/vpncheck
systemctl status openvpn-client@nyc > /tmp/vpncheck

#location of the vpncheck files
#$vpnCheck="/tmp/vpncheck"

        #check for errors and if so notify user and kill transmission
	if ( $( grep -qi "error" "/tmp/vpncheck" ) ); then
		zenity --error --height=100 --width=200 --text="<span>OpenVPN Service has Errors, Transmission killed</span>" --title="Systemctl - Error" --ok-label="Ok"
		pkill -9 $(pidof transmission-gtk)
		systemctl stop transmission-daemon
		systemctl stop transmission
	fi


        #if grep finds any of these phrases in log files restart vpn
        if ( $( grep -qi "sigusr1" "/tmp/vpncheck" ) || $( grep -qi "tlS error" "/tmp/vpncheck") ); then

            systemctl restart openvpn-client@nyc
            #don't forget to add routes after openvpn is restarted if needed
            #ip route add default via 192.168.1.1 dev wlp0s18f2u1 table novpn
            #echo "Restored route for ssh connections" | sudo tee -a /tmp/vpncheck

        fi    


ping -c 4 4.2.2.2 >> /tmp/vpncheck

        if ( $( grep -qi "100% packet loss" "/tmp/vpncheck") ); then

            systemctl restart openvpn-client@nyc

        fi
