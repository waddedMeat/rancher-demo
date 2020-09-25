# -*- mode: ruby -*-
# vi: set ft=ruby :

$host_script = <<-SCRIPT
cat <<EOF >> /etc/hosts

# developer/admin authorized workstation
192.168.10.20 workstation

# k8s nodes
192.168.10.21 node-1

# Rancher Server - this should point to a load balancer; not an individual node
192.168.10.21 rancher.example.com

EOF

SCRIPT


Vagrant.configure("2") do |config|

  config.vm.define "workstation" do |config|
    config.vm.box = "centos/7"

    # setup private network with host file entries
    config.vm.network "private_network", ip: "192.168.10.20"
    config.vm.hostname = 'workstation'
    config.vm.provision "shell", inline: $host_script

    # install rke, kubectl, helm on the workstation
    config.vm.provision "shell", path: "provision/tools/rke.sh"
    config.vm.provision "shell", path: "provision/tools/kubectl.sh"
    config.vm.provision "shell", path: "provision/tools/helm.sh"

  end

  (1..1).each do |i|
  config.vm.define "node-1" do |config|

    config.vm.box = "centos/7"

    # setup private network with host file entries
    config.vm.hostname = 'node-1'
    config.vm.network "private_network", ip: "192.168.10.#{20+i}"
    config.vm.provision "shell", inline: $host_script

    # prepare server for k8s
    config.vm.provision "shell", path: "provision/k8s-node-init.sh"

    # run firewall rules for each node role
    config.vm.provision "shell", path: "provision/firewall-rules/control-plane.sh"
    config.vm.provision "shell", path: "provision/firewall-rules/etcd.sh"
    config.vm.provision "shell", path: "provision/firewall-rules/worker.sh"

    # install docker (you have to restart docker if the firewall rules change)
    config.vm.provision "shell", path: "provision/tools/docker.sh"

#    config.vm.provider :virtualbox do |vb|
#      vb.customize ["modifyvm", :id, "--memory", "4096"]
#      vb.customize ["modifyvm", :id, "--cpus", "2"]
#    end

  end
  end

end
