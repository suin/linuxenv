# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'etc'

host_username = Etc.getlogin

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Prefer VMware Fusion before VirtualBox
  config.vm.provider "vmware_desktop"
  config.vm.provider "virtualbox"

  config.vm.hostname = "linuxenv"
  config.vm.define "linuxenv"

  config.vm.network :forwarded_port, host: 3000, guest: 3000
  config.vm.network :forwarded_port, host: 3306, guest: 3306

  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
    v.vmx["displayname"] = "linuxenv"
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
    v.clone_directory = '~/vagrant'
  end

  config.vm.synced_folder "/Volumes/dev", "/Volumes/dev", type: "nfs", fsevents: true,
    mount_options: ['rw', 'vers=3', 'tcp'],
    linux__nfs_options: ['rw','no_subtree_check','all_squash','async']
  config.vm.synced_folder "/Users/suin", "/Users/suin", type: "nfs",
    mount_options: ['rw', 'vers=3', 'tcp'],
    linux__nfs_options: ['rw','no_subtree_check','all_squash','async']
  config.nfs.map_uid = Etc.getpwnam(host_username).uid
  config.nfs.map_gid = Etc.getpwnam(host_username).gid

  config.trigger.after [:up, :resume] do |t|
    t.name = "vagrant-fsevents-start"
    t.run = { inline: "./vagrant-fsevents.sh start" }
  end

  config.trigger.after [:halt, :suspend, :destroy] do |t|
    t.name = "vagrant-fsevents-stop"
    t.run = { inline: "./vagrant-fsevents.sh stop" }
  end

  vagrant_status_cache_file = './vagrant-status-running.cache'
  config.trigger.after [:up, :resume] do |t|
    t.name = "Creating Vagrant status cache file"
    t.ruby do |env, machine|
      File.write(vagrant_status_cache_file, '')
    end
  end

  config.trigger.after [:halt, :suspend, :destroy] do |t|
    t.name = "Deleting Vagrant status cache file"
    t.ruby do |env, machine|
      File.delete(vagrant_status_cache_file) if File.exist?(vagrant_status_cache_file)
    end
  end

  # SSH login as root by default
  config.vm.provision "shell", inline: <<-SHELL
    set -x
    grep -qxF 'exec sudo su -' /home/vagrant/.bashrc || echo 'exec sudo su -' >> /home/vagrant/.bashrc
  SHELL

  # Configure root's .bashrc
  config.vm.provision "shell", inline: <<-SHELL
    set -x
    grep -qxF 'source /vagrant/.bash_profile' /root/.bashrc || echo 'source /vagrant/.bash_profile' >> /root/.bashrc
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

  # Install Docker Compose
  config.vm.provision "shell", inline: <<-SHELL
    set -x
    curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
  SHELL
end
