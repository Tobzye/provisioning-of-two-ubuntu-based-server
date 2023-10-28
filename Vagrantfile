# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define "Master" do |master|
    master.vm.hostname = "master"
    master.vm.box = "ubuntu/bionic64"
    master.vm.network "private_network", type: "dhcp"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    master.vm.provision "shell", path: "lamp.sh"
  end


  config.vm.define "Slave" do |slave|
    slave.vm.hostname = "slave"
    slave.vm.box = "ubuntu/bionic64"
    slave.vm.network "private_network", ip: "192.168.33.10"
    slave.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end

    slave.vm.provision "ansible" do |ansible|
      ansible.playbook = "slaveprovision.yml" # Replace with your playbook filename
    end
  end
end
