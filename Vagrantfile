# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "precise32"
  config.vm.box = "debian-wheezy72-amd64-vbox43"
  #config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/197673519/debian-7.2.0.box"
  config.vm.hostname = "puppet.dev"
  #config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.56.101"
  config.vm.synced_folder ".", "/vagrant/"
  config.vm.synced_folder "./www", "/var/www/dev/puppet/www", nfs: true
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    #vb.customize ["modifyvm", :id, "--name", "Ubuntu 12.04"]
    vb.customize ["modifyvm", :id, "--name", "Debian Wheezy 7.02"]
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision :shell, :inline => "echo \"Europe/Prague\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "base.pp"
  end
end
