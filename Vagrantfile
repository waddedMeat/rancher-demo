# -*- mode: ruby -*-
# vi: set ft=ruby :

# All In One
# Rancher recommends a 3 AIO node cluster to run the Rancher Server
AIO_NODES = 1

# Rancher recommends min of 3 etcd nodes for production
ETCD_NODES = 0
# Rancher recommends min of 2 controlplane nodes for production
CONTROLPLANE_NODES = 0

# Master Node combines both etcd and controlplane on a single node
MASTER_NODES = 0

# Rancher recommends min of 2 worker nodes for production
WORKER_NODES = 0







Vagrant.configure("2") do |config|

  # allow password login for all boxes
  config.vm.provision "shell", inline: <<-EOF
  set -eux;
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
  systemctl restart sshd;

  EOF


  # Workstation with admin tools
  config.vm.define "workstation" do |config|
    config.vm.box = "centos/7"

    config.vm.network "private_network", ip: "192.168.10.10"

    # install rke, kubectl, helm on the workstation
    config.vm.provision "shell", path: "provision/tools/rke.sh"
    config.vm.provision "shell", path: "provision/tools/kubectl.sh"
    config.vm.provision "shell", path: "provision/tools/helm.sh"

    # prepare server to run key script
    config.vm.provision "shell", args: [AIO_NODES + ETCD_NODES + CONTROLPLANE_NODES + MASTER_NODES + WORKER_NODES], inline: <<-EOF
    set -eux;
    echo $1 > /etc/vagrant_node_count;
    yum install -y sshpass;

    EOF

  end

  # CREATE NODES

  # idx to keep track of all nodes
  idx=0

  # loop through possible node configurations
  # bits are:
  # 1 - worker
  # 2 - controlplane
  # 4 - etcd
  {0b111 => AIO_NODES, 0b110 => MASTER_NODES, 0b100 => ETCD_NODES, 0b010 => CONTROLPLANE_NODES, 0b001 => WORKER_NODES}.each do |type, cnt|
  
    (1..cnt).each do
    
      # increment the node index for each definition
      idx = idx + 1
      config.vm.define "node-#{idx}" do |config|

        config.vm.box = "centos/7"

        config.vm.network "private_network", ip: "192.168.10.#{10 + idx}"

        # prepare server for k8s
        config.vm.provision "shell", path: "provision/k8s-node-init.sh"

        # count number of roles assigned per node
        roleCnt = 0 

        # run firewall rules for each node role
        if type & 0b100 != 0
          config.vm.provision "shell", path: "provision/firewall-rules/etcd.sh"
          roleCnt += 1
        end

        if type & 0b010 != 0
          config.vm.provision "shell", path: "provision/firewall-rules/control-plane.sh"
          roleCnt += 1
        end

        if type & 0b001 != 0
          roleCnt += 1
        end

        # install docker (you have to restart docker if the firewall rules change)
        config.vm.provision "shell", path: "provision/tools/docker.sh"

        if roleCnt > 1

          config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", 1024 * roleCnt]
            vb.customize ["modifyvm", :id, "--cpus", 2]
          end

        end
      end
    end
  end
end
