#! /bin/bash






kubectl -n cattle-system create secret tls tls-rancher-ingress --key tls.key --cert tls.crt
