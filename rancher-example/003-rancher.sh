#! /bin/bash

# add the helm repo
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
  
# install rancher
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --create-namespace \
  -f values.yaml
