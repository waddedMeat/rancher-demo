#! /bin/bash

openssl req -newkey rsa:4096 \
    -x509 \
    -sha256 \
    -days 3650 \
    -nodes \
    -out tls.crt \
    -keyout tls.key \
    -subj "/C=SI/ST=Ljubljana/L=Ljubljana/O=Security/OU=IT Department/CN=rancher.example.com"

kubectl -n cattle-system create secret tls tls-rancher-ingress --key tls.key --cert tls.crt
