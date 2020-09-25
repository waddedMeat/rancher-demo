#! /bin/bash
set -eux

curl -L -s https://github.com/rancher/rke/releases/download/v1.1.4/rke_linux-amd64 -o /usr/local/bin/rke

chmod a+x /usr/local/bin/rke

