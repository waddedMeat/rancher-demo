#! /bin/bash
set -eux

export VERIFY_CHECKSUM="false"

export PATH=$PATH:/usr/local/bin

curl -L -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
