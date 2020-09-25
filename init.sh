#! /bin/bash
set -e

# create key
vagrant ssh workstation -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa"
key=$(vagrant ssh workstation -c "cat ~/.ssh/id_rsa.pub")

# add key to running servers
running=$(vagrant status | grep running | awk '{print $1}' | grep -v workstation)
for server in ${running[@]}; do
    echo $key | vagrant ssh $server -c "cat >> ~/.ssh/authorized_keys"
    vagrant ssh workstation -c "ssh-keyscan -H $server >> ~/.ssh/known_hosts"
done

