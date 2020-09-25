Rancher Demo
---

# Vagrnat
vagrant up

## workstation
This is the "workstation" that includes all of the tools necessary to create and manage a RKE cluster.

## nodes
The server(s) that will be running the RKE cluster

NOTE: These servers (nodes) should be behind a load balancer with health checks

# RKE

## Server Provisoning

RKE nodes requires specifc roles assigned to each node
1. controlplane - controls the cluster
2. etcd - data storage for controlplane (not userland)
3. worker - executes userland pods

Each server requires a set of firewall rules based upon their assigned role

RKE REQUIRES docker (only supported continer runtime)

provision/
├── firewall-rules
│   ├── control-plane.sh
│   ├── etcd.sh
│   └── worker.sh
├── k8s-node-init.sh
└── tools
    ├── docker.sh
    ├── helm.sh
    ├── kubectl.sh
    └── rke.sh



RKE 
setup-keys.sh

# Rancher
