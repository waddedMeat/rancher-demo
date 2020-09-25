#!/bin/bash

# DO NOT ALLOW PUBLIC ACCESS TO THESE SERVERS

# For etcd nodes, run the following commands:

firewall-cmd --permanent --add-port=2376/tcp
firewall-cmd --permanent --add-port=2379/tcp
firewall-cmd --permanent --add-port=2380/tcp
firewall-cmd --permanent --add-port=8472/udp
firewall-cmd --permanent --add-port=9099/tcp
firewall-cmd --permanent --add-port=10250/tcp

systemctl restart firewalld

