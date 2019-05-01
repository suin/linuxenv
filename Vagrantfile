# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Prefer VMware Fusion before VirtualBox
  config.vm.provider "vmware_desktop"
  config.vm.provider "virtualbox"

  config.vm.hostname = "linuxenv"
  config.vm.define "linuxenv"

  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
    v.vmx["displayname"] = "linuxenv"
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
    v.clone_directory = '~/vagrant'
  end

  config.vm.synced_folder "/Volumes/dev", "/Volumes/dev", type: "nfs"
  config.vm.synced_folder "/Users/suin", "/Users/suin", type: "nfs"

  # SSH login as root by default
  config.vm.provision "shell", inline: <<-SHELL
    set -x
    echo "exec sudo su -" >> .bashrc
  SHELL

  # Install Docker CE
  config.vm.provision "shell", inline: <<-SHELL
    set -x
    apt-get -qq update
    apt-get -qq -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    apt-get -qq update
    apt-get -qq -y install docker-ce docker-ce-cli containerd.io
  SHELL
end
