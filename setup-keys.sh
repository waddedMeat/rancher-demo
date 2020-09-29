#! /bin/bash
set -e

# create key
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

for i in $(seq 1 $(cat /etc/vagrant_node_count)); do
    ip="192.168.10.$((10 + $i))"
    ssh-keyscan $ip >> /home/vagrant/.ssh/known_hosts
    sshpass -p vagrant ssh-copy-id $ip
done

