# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
  # Globals
  config.winrm.transport = :plaintext
  config.winrm.basic_auth_only = true
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  
  config.vm.define "globo-dc01" do |web|
    web.vm.guest = :windows
    web.vm.communicator = :winrm
    web.vm.box = "jptoto/winsrv2019"
    web.vm.hostname = "globo-dc01"
    web.vm.network "private_network", ip: "10.0.2.10"
    
    web.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
    
      # Customize the amount of memory on the VM:
      vb.memory = "2048"
    end

    # Provision actions for the domain controller
    #web.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "scripts/01_install_configure_ad.ps1"
    #web.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "scripts/02_post_domain_configuration.ps1"
  end

  config.vm.define "globo-web01" do |web|
    web.vm.guest = :windows
    web.vm.communicator = :winrm
    web.vm.box = "jptoto/winsrv2019"
    web.vm.hostname = "globo-web01"
    web.vm.network "private_network", ip: "10.0.2.11"
    
    web.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
    
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end

    # Provision actions for the domain member
    #web.vm.provision "windows-sysprep"
    web.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "scripts/03_member_domain_join.ps1"
  end

  
end
