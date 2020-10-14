#!/bin/bash

#copy 3 files to their required locations
cp vpncheck.service /usr/lib/systemd/system
cp vpncheck.sh /usr/bin
cp vpncheck.timer /usr/lib/systemd/system
systemctl enable vpncheck.timer
systemctl start vpncheck.timer
