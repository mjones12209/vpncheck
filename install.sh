#!/bin/bash

#copy 3 files to their required locations
cp vpncheck.service /usr/lib/systemd/system
cp vpncheck.sh /usr/bin
cp vpncheck.timer /usr/lib/systemd/system
cp openvpn-reconnect.service /usr/lib/systemd/system
systemctl daemon-reload
systemctl enable vpncheck.timer openvpn-reconnect
systemctl start vpncheck.timer openvpn-reconnect
