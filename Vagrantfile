# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.define "docker-apache" do |docker-apache|
    config.vm.box = "generic/ubuntu2204"

    # copies the current folder to the VM
    # config.vm.synced_folder ".", "/home/vagrant/docker-apache"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
    config.vm.network "forwarded_port", guest: 7860, host: 7860

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
    config.vm.network "public_network"

  # Share an additional folder to the guest VM.
  # config.vm.synced_folder "./data", "/vagrant_data"

    config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    # Customize the amount of memory on the VM:
      vb.memory = "8192"
      vb.name = "docker-apache"
      vb.cpus = 6
    end
  
    # View the documentation for the provider you are using for more
    # information on available options.

    # Enable provisioning with a shell script. Additional provisioners such as
    # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
    # documentation for more information about their specific syntax and use.
    config.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common git
      curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
      sudo chmod 755 /usr/local/bin/dry
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
      sudo curl -L "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      sudo usermod -aG docker vagrant 
    SHELL

    # Run the containers, and register as service
    config.vm.provision "shell", inline: <<-SHELL
      sudo newgrp docker

      cd /home/vagrant/docker-apache
      git clone https://github.com/rpstreef/docker-apache-reverse-proxy .

      docker-compose up -d
      sudo bash -c 'echo "[Unit]
      Description=Docker Compose Application Service
      After=docker.service
      Requires=docker.service

      [Service]
      Type=forking
      WorkingDirectory=/home/vagrant/docker-apache/
      ExecStart=/usr/local/bin/docker-compose up -d
      TimeoutStartSec=0
      Restart=on-failure

      [Install]
      WantedBy=multi-user.target" > /etc/systemd/system/docker-compose.service'
      sudo systemctl enable docker-compose.service
      sudo systemctl start docker-compose.service
    SHELL
  end
end
